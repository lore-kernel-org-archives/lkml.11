Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24FEC43217
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Apr 2022 22:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358364AbiDSWzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Apr 2022 18:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241646AbiDSWzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 18:55:21 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF01A2AC4F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 15:52:36 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id h8so33697539ybj.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 15:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dGxEPoSmeIiVN+kWljOoFUiaxfdNkmXv2+VPeoexn/w=;
        b=tLO1vkuyKGUcdIGMRyqZPIO+6Fs0Rt8QeQ7ExLtvOHs5wEaTl37TJYbK6zmfS/YBKn
         6LNlNNePHFM3X5wx0v0ciGBBVCNE07I6dL5tVEn4c0Xzu1jeUTlHhvtrwPamCBgt6YEz
         0zgKS84hV+mFniAnhe1MDszKaKbVUPBG0Zjw6dOiZiguUA0gXQOC2YOsMKTIT3zLhRo+
         4tTbEWC13mFVP1rIfPX7ZZtYaUSn0Nd9pKF7lZvMVD3EnI+OthLQIdy74bqzDzjuRQyb
         UGvxnDETSUCE9S1Or5u6RhuIokP3lEE3EyYF2uSil640/kBW7m1s87/G/7lvNIykBSyq
         0tIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dGxEPoSmeIiVN+kWljOoFUiaxfdNkmXv2+VPeoexn/w=;
        b=2A0eKANLpJkSMdMfUv5FLhvP8gT4ui2bpMf1hgOD+HLwg7XDMz8bnPQi9Uoix1LLJ+
         1+PbmEGQtXM8qAc0GT47vBO4bXkuPJcFH8XjmLZ7e/BYACEW+WBdvcakZihZG0kXqg3e
         ilhJXJnv74ax+1bptTp2r1EIPp7KAX4qmmonrSjquXZXc886fW2tBNv+H3C1mdouYn52
         EKM2nbweQfO2aE0bcvSzlsyvra7Orh/cV56A6PkOZ/rKrqwKAnOD0dgslE1KcaWpdk1y
         BJMUpLvtKKc+qb+L/jDUouCy6SiUFEZ78/klAJbX4AQkbp6suKhow0OIIlEO/jdu7ICO
         6mWQ==
X-Gm-Message-State: AOAM533LPCMzme6ayTEXf9tEf+LgbZZePQhknh6C3PIcZ1cx/vmWyHc2
        rgX/uqwxfWCohzHyUzN82zDa5+i3IRCT4zaL7eutV0reoO4=
X-Google-Smtp-Source: ABdhPJyJrXEZ2TUGlRwB5uW/Zc+cwpXk4Rq+ww8H648TL0zPn9ZcG1qzvHfQBTBZn7txEdFekcEnbQbza7oUOPpNlPs=
X-Received: by 2002:a25:a12a:0:b0:644:e94e:5844 with SMTP id
 z39-20020a25a12a000000b00644e94e5844mr12696268ybh.492.1650408756081; Tue, 19
 Apr 2022 15:52:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220401023306.79532-1-frank@zago.net> <20220401023306.79532-3-frank@zago.net>
In-Reply-To: <20220401023306.79532-3-frank@zago.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 20 Apr 2022 00:52:24 +0200
Message-ID: <CACRpkdZFQtPkWWNFZEDVKtoGYEL9+g5iEZVozWxuQmVpx4+8Ag@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] gpio: ch341: add GPIO MFD cell driver for the CH341
To:     frank@zago.net
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Wolfram Sang <wsa@kernel.org>, Johan Hovold <johan@kernel.org>,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 1, 2022 at 4:33 AM frank zago <frank@zago.net> wrote:

> The GPIO interface offers 16 GPIOs. 6 are read/write, and 10 are
> read-only.
>
> Signed-off-by: frank zago <frank@zago.net>

Looks good to me:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Yours,
Linus Walleij
