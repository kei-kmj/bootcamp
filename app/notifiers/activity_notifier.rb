# frozen_string_literal: true

class ActivityNotifier < ApplicationNotifier
  self.driver = ActivityDriver.new
  self.async_adapter = ActivityAsyncAdapter.new

  def graduated(params = {})
    params.merge!(@params)
    sender = params[:sender]
    receiver = params[:receiver]

    notification(
      body: "๐๏ธ #{sender.login_name}ใใใๅๆฅญใใพใใ๏ผ",
      kind: :graduated,
      sender: sender,
      receiver: receiver,
      link: Rails.application.routes.url_helpers.polymorphic_path(sender),
      read: false
    )
  end

  def consecutive_sad_report(params = {})
    params.merge!(@params)
    report = params[:report]
    receiver = params[:receiver]

    notification(
      body: "#{report.user.login_name}ใใใ#{User::DEPRESSED_SIZE}ๅ้ฃ็ถใงsadใขใคใณใณใฎๆฅๅ ฑใๆๅบใใพใใใ",
      kind: :consecutive_sad_report,
      sender: report.sender,
      receiver: receiver,
      link: Rails.application.routes.url_helpers.polymorphic_path(report),
      read: false
    )
  end

  def assigned_as_checker(params = {})
    params.merge!(@params)
    product = params[:product]
    receiver = params[:receiver]

    notification(
      body: "#{product.user.login_name}ใใใฎๆๅบ็ฉ#{product.title}ใฎๆๅฝใซใชใใพใใใ",
      kind: :assigned_as_checker,
      sender: product.sender,
      receiver: receiver,
      link: Rails.application.routes.url_helpers.polymorphic_path(product),
      read: false
    )
  end

  def came_comment(params = {})
    params.merge!(@params)
    comment = params[:comment]
    receiver = params[:receiver]
    message = params[:message]
    link = params[:link]

    notification(
      body: message,
      kind: :came_comment,
      receiver: receiver,
      sender: comment.sender,
      link: link,
      read: false
    )
  end

  def came_question(params = {})
    params.merge!(@params)
    question = params[:question]
    receiver = params[:receiver]

    notification(
      body: "#{question.user.login_name}ใใใใ่ณชๅใ#{question.title}ใใๆ็จฟใใใพใใใ",
      kind: :came_question,
      receiver: receiver,
      sender: question.sender,
      link: Rails.application.routes.url_helpers.polymorphic_path(question),
      read: false
    )
  end

  def submitted(params = {})
    params.merge!(@params)
    subject = params[:subject]
    receiver = params[:receiver]
    message = params[:message]

    notification(
      body: message,
      kind: :watching,
      sender: subject.user,
      receiver: receiver,
      link: Rails.application.routes.url_helpers.polymorphic_path(subject),
      read: false
    )
  end

  def create_page(params = {})
    params.merge!(@params)
    page = params[:page]
    receiver = params[:receiver]

    notification(
      body: "#{page.user.login_name}ใใใDocsใซ#{page.title}ใๆ็จฟใใพใใใ",
      kind: :create_pages,
      sender: page.sender,
      receiver: receiver,
      link: Rails.application.routes.url_helpers.polymorphic_path(page),
      read: false
    )
  end

  def first_report(params = {})
    params.merge!(@params)
    report = params[:report]
    receiver = params[:receiver]

    notification(
      body: "๐ #{report.user.login_name}ใใใใฏใใใฆใฎๆฅๅ ฑใๆธใใพใใ๏ผ",
      kind: :first_report,
      receiver: receiver,
      sender: report.sender,
      link: Rails.application.routes.url_helpers.polymorphic_path(report),
      read: false
    )
  end

  def post_announcement(params = {})
    params.merge!(@params)
    announce = params[:announcement]
    receiver = params[:receiver]

    notification(
      body: "ใ็ฅใใใ#{announce.title}ใ",
      kind: :announced,
      sender: announce.user,
      receiver: receiver,
      link: Rails.application.routes.url_helpers.polymorphic_path(announce),
      read: false
    )
  end

  def retired(params = {})
    params.merge!(@params)
    sender = params[:sender]
    receiver = params[:receiver]

    notification(
      body: "๐ข #{sender.login_name}ใใใ้ไผใใพใใใ",
      kind: :retired,
      sender: sender,
      receiver: receiver,
      link: Rails.application.routes.url_helpers.polymorphic_path(sender),
      read: false
    )
  end

  def hibernated(params = {})
    params.merge!(@params)
    sender = params[:sender]
    receiver = params[:receiver]

    notification(
      body: "#{sender.login_name}ใใใไผไผใใพใใใ",
      kind: :hibernated,
      sender: sender,
      receiver: receiver,
      link: Rails.application.routes.url_helpers.polymorphic_path(sender),
      read: false
    )
  end

  def comebacked(params = {})
    params.merge!(@params)
    sender = params[:sender]
    receiver = params[:receiver]

    notification(
      body: "#{sender.login_name}ใใใไผไผใใๅพฉๅธฐใใพใใ๏ผ",
      kind: :comebacked,
      sender: sender,
      receiver: receiver,
      link: Rails.application.routes.url_helpers.polymorphic_path(sender),
      read: false
    )
  end

  def signed_up(params = {})
    params.merge!(@params)
    sender = params[:sender]
    sender_roles = params[:sender_roles].empty? ? '' : "(#{params[:sender_roles]})"
    receiver = params[:receiver]

    notification(
      body: "๐ #{sender.login_name}ใใ#{sender_roles}ใๆฐใใๅฅไผใใพใใ๏ผ",
      kind: :signed_up,
      sender: sender,
      receiver: receiver,
      link: Rails.application.routes.url_helpers.polymorphic_path(sender),
      read: false
    )
  end

  def mentioned(params = {})
    params.merge!(@params)
    mentionable = params[:mentionable]
    receiver = params[:receiver]

    notification(
      body: "#{mentionable.where_mention}ใง#{mentionable.sender.login_name}ใใใใใกใณใทใงใณใใใพใใใ",
      kind: :mentioned,
      receiver: receiver,
      sender: mentionable.sender,
      link: mentionable.path,
      read: false
    )
  end

  def following_report(params = {})
    params.merge!(@params)
    report = params[:report]
    receiver = params[:receiver]

    notification(
      body: "#{report.user.login_name}ใใใๆฅๅ ฑใ #{report.title} ใใๆธใใพใใ๏ผ",
      kind: :following_report,
      receiver: receiver,
      sender: report.sender,
      link: Rails.application.routes.url_helpers.polymorphic_path(report),
      read: false
    )
  end

  def came_answer(params = {})
    params.merge!(@params)
    answer = params[:answer]

    notification(
      body: "#{answer.user.login_name}ใใใใๅ็ญใใใใพใใใ",
      kind: :answered,
      receiver: answer.receiver,
      sender: answer.sender,
      link: Rails.application.routes.url_helpers.polymorphic_path(answer.question),
      read: false
    )
  end

  def three_months_after_retirement(params = {})
    params.merge!(@params)
    sender = params[:sender]
    receiver = params[:receiver]

    notification(
      body: "#{I18n.t('.retire_notice', user: sender.login_name)}Discord ID: #{sender.discord_account}, ใฆใผใถใผใใผใธ: https://bootcamp.fjord.jp/users/#{sender.id}",
      kind: :retired,
      sender: sender,
      receiver: receiver,
      link: Rails.application.routes.url_helpers.polymorphic_path(sender),
      read: false
    )
  end

  def checked(params = {})
    params.merge!(@params)
    check = params[:check]
    receiver = params[:receiver]

    notification(
      body: "#{check.sender.login_name}ใใใ#{check.checkable.title}ใ็ขบ่ชใใพใใใ",
      kind: :checked,
      receiver: receiver,
      sender: check.sender,
      link: Rails.application.routes.url_helpers.polymorphic_path(check.checkable),
      read: false
    )
  end

  def trainee_report(params = {})
    params.merge!(@params)
    report = params[:report]
    receiver = params[:receiver]

    notification(
      body: "#{report.user.login_name}ใใใๆฅๅ ฑใ #{report.title} ใใๆธใใพใใ๏ผ",
      kind: :trainee_report,
      receiver: receiver,
      sender: report.sender,
      link: Rails.application.routes.url_helpers.polymorphic_path(report),
      read: false
    )
  end

  def product_update(params = {})
    params.merge!(@params)
    product = params[:product]
    receiver = params[:receiver]

    notification(
      body: "#{product.user.login_name}ใใใฎๆๅบ็ฉใๆดๆฐใใใพใใ",
      kind: :product_update,
      receiver: receiver,
      sender: product.sender,
      link: Rails.application.routes.url_helpers.polymorphic_path(product),
      read: false
    )
  end

  def watching_notification(params = {})
    params.merge!(@params)
    watchable = params[:watchable]
    receiver = params[:receiver]
    sender = params[:comment].user
    action = watchable.instance_of?(Question) ? 'ๅ็ญ' : 'ใณใกใณใ'
    notification(
      body: "#{watchable.user.login_name}ใใใฎใ #{watchable.notification_title} ใใซ#{sender.login_name}ใใใ#{action}ใใพใใใ",
      kind: :watching,
      receiver: receiver,
      sender: sender,
      link: Rails.application.routes.url_helpers.polymorphic_path(watchable),
      read: false
    )
  end

  def update_regular_event(params = {})
    params.merge!(@params)
    regular_event = params[:regular_event]
    receiver = params[:receiver]

    notification(
      body: "ๅฎๆใคใใณใใ#{regular_event.title}ใใๆดๆฐใใใพใใใ",
      kind: :regular_event_updated,
      receiver: receiver,
      sender: regular_event.user,
      link: Rails.application.routes.url_helpers.polymorphic_path(regular_event),
      read: false
    )
  end

  def no_correct_answer(params = {})
    params.merge!(@params)
    question = params[:question]
    receiver = params[:receiver]

    notification(
      body: "Q&Aใ#{question.title}ใใฎใในใใขใณใตใผใใพใ ้ธใฐใใฆใใพใใใ",
      kind: :no_correct_answer,
      receiver: receiver,
      sender: question.sender,
      link: Rails.application.routes.url_helpers.polymorphic_path(question),
      read: false
    )
  end

  def moved_up_event_waiting_user(params = {})
    params.merge!(@params)
    event = params[:event]
    receiver = params[:receiver]

    notification(
      body: "#{event.title}ใงใ่ฃๆฌ ใใๅๅ ใซ็นฐใไธใใใพใใใ",
      kind: :moved_up_event_waiting_user,
      receiver: receiver,
      sender: event.user,
      link: Rails.application.routes.url_helpers.polymorphic_path(event),
      read: false
    )
  end
end
