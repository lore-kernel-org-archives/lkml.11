Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38E7C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Feb 2022 01:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbiBJB47 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Feb 2022 20:56:59 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbiBJB4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 20:56:08 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F282BB23
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 17:52:34 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id m10so4512312oie.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 17:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=dlJhRUB01qZhsIVXIk2dwYqihYxKbJJNnkUeg5WkvEQ=;
        b=jqEM46I7RIpOv6Dkxw9TpDQEzfSMQUsHfWjfCF5R1hPNJotrhb4Hfvk9+dGhmfKApj
         +tj8cpWNtVh8qXkYopCvZcUdjJsZe3FyUvDPDzzCXvx+Oqb6TBj6gc/T9MGLB2oTBy5K
         rXt8rxgL2hjvC7PB90SynvANEC3ghpyWEBImk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=dlJhRUB01qZhsIVXIk2dwYqihYxKbJJNnkUeg5WkvEQ=;
        b=yuFyIetU9QzQefYs5Oom43/4dzdudntdVjVxnw9WS/T/7b7ogPHjGJ/3FXmXRfBXVK
         Kn1ibaVPh8Uods0ZQMeqkfks/m9BVshvG5ZZHMYAwCsfzW2guCKvsgo3grTVNYVdu8xJ
         eFPCz1P6qndVOkH8nkSRa1Wqx1ij654fIGCqPZz9bNcGwMktgTeqhoUYIKhEIbBXGwmk
         98myAmcJiAWgchBJq4JjtlY3mRHEiXS8oddpsXqjHrHkvpl2ej7hUyL1P2rI13A9Z2/T
         9W2axc0pwy8c6Ycw3nvZ7hm9sEo2BdFP8HTdEXofgTCY//QbfWJjn0JrsOi2a5HvA8XQ
         rhQA==
X-Gm-Message-State: AOAM531/nZjx2Qg23XpmcvrzipD3gZykp1fX+wfh9K9PiMC51VcPfH8p
        UB9+VR4UJLRFms86MCVx3i+PIPk2SUzFD0DfLBTT5+DQO8k=
X-Google-Smtp-Source: ABdhPJzKZSUzft7pAYTMnnD+ET8CryZqIpC5vdW5rpze6mP8SDxIf5u1xXG74DImb5hLX73mc2qCjE47u65UInz2yIk=
X-Received: by 2002:aca:df82:: with SMTP id w124mr2220442oig.112.1644451553163;
 Wed, 09 Feb 2022 16:05:53 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Feb 2022 16:05:52 -0800
MIME-Version: 1.0
In-Reply-To: <c17e95f7-9c42-657a-8525-3937d4b27fb8@quicinc.com>
References: <1644334454-16719-1-git-send-email-quic_srivasam@quicinc.com>
 <1644334454-16719-3-git-send-email-quic_srivasam@quicinc.com>
 <CAE-0n52LGY2amCKo+40D4BoSsANs7JeQ0t_4QfeXNC5q64Ccwg@mail.gmail.com> <c17e95f7-9c42-657a-8525-3937d4b27fb8@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 9 Feb 2022 16:05:52 -0800
Message-ID: <CAE-0n51o3ohrVO-HCeVOTz=JwePA63yMrNpFsY4sFOiv6rQwEA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: sc7280: add lpass lpi pin
 controller node
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, dianders@chromium.org,
        judyhsiao@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        rohitkr@codeaurora.org, srinivas.kandagatla@linaro.org
Cc:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivasa Rao Mandadapu (2022-02-09 06:01:21)
>
> On 2/9/2022 2:41 AM, Stephen Boyd wrote:
> > Quoting Srinivasa Rao Mandadapu (2022-02-08 07:34:13)
> >> +                       data {
> >> +                               pins = "gpio7";
> >> +                               function = "dmic1_data";
> >> +                               drive-strength = <8>;
> >> +                               input-enable;
> >> +                       };
> >> +               };
> >> +
> >> +               dmic01_sleep: dmic01-sleep-pins {
> >> +                       clk {
> >> +                               pins = "gpio6";
> >> +                               function = "dmic1_clk";
> >> +                               drive-strength = <2>;
> >> +                               bias-disable;
> >> +                               output-low;
> >> +                       };
> >> +
> >> +                       data {
> >> +                               pins = "gpio7";
> >> +                               function = "dmic1_data";
> >> +                               drive-strength = <2>;
> >> +                               pull-down;
> >> +                               input-enable;
> > Why does input-enable matter? It's not a gpio.
> Actually the same is fallowed in sm8250.dtsi. Verified without it and
> working fine. Need take call on it.

Is that because the pin is already an input by default? What does gpio
debugfs say for this pin? Does it also work if you make it
output-low/output-high here? I thought that the gpio itself isn't muxed
out to the pad unless the function is "gpio" so I hope the input/output
settings have no effect here.
