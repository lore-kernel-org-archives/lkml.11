Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D991AC4332F
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Feb 2022 18:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbiBYSGv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Feb 2022 13:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbiBYSGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 13:06:49 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC931E6E97
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 10:06:16 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id p206-20020a4a2fd7000000b0031bfec11983so7207553oop.13
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 10:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=I6MkJlQQ4hU61fN5YrqAtX/5cqN/fcZrZGOgyZvO0uI=;
        b=OX3tyht/4LSsOvRcTrgfeXkyb76HiSQ7W8pI7J/RTBbroR/+j4T5kvlW2WmKmUzG/H
         xu2NViAASbIERVgMW/VanajirDvxVwf0ERZWB7p3LhGVPmT1IPo1TuayrNHhrLPZUOdz
         XJcFu2aCb6m5c3GwxNFlRaO8UGW/64pJTguBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=I6MkJlQQ4hU61fN5YrqAtX/5cqN/fcZrZGOgyZvO0uI=;
        b=5CaPQ9l/x3dhBrjuQzTX4wH+gBjdMufuYNINUi/sQfewxcBbQ79zZ3i1TNCULxAhfs
         UtO1QpvcOOEksQBd8UT6uez7tiNz+X3lXuW8dKins+3d64V7/rlfQlhDRhNJEZNrsNvu
         qqOhMSQGOt1JCfoLLbxk/kZE8oBBnGhPNJDO1FljDQilegygJSyfGXI6jtLr12v+9MIF
         Z2S7IyWBMuPG1kOqmBe6OizZ8hjmkwdKrUSo9U3vwSqy7hfFeQ/wXKSpEWdUfY7t4RA0
         8jMpJqXEa03E7LS+N8mkulgYbYaNEwtAy5TDxYsrJWbdtsWBDznSkgpXm/0oF7uz6lnF
         NdiA==
X-Gm-Message-State: AOAM530+rHLNfIK75YAERe/tJRbF9uagzoK6HJtBtRPokMHwyCwu2bqU
        N82tYuxRR2RUe1ZlxFEJ3FOLjlglSywL6CafrFw75A==
X-Google-Smtp-Source: ABdhPJwRntMGqiM80NVcK8YfATn8ptbQGr+zoLTrJsgW0P2rhsjH5L4rwRJB1IJxViwSIqXbAU1GJUTof7bUMNm0RH8=
X-Received: by 2002:a05:6870:5829:b0:c8:9f42:f919 with SMTP id
 r41-20020a056870582900b000c89f42f919mr2012649oap.54.1645812375839; Fri, 25
 Feb 2022 10:06:15 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 25 Feb 2022 10:06:15 -0800
MIME-Version: 1.0
In-Reply-To: <1645804670-21898-2-git-send-email-quic_vpolimer@quicinc.com>
References: <1645804670-21898-1-git-send-email-quic_vpolimer@quicinc.com> <1645804670-21898-2-git-send-email-quic_vpolimer@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 25 Feb 2022 10:06:15 -0800
Message-ID: <CAE-0n52OPUEMO4iXP_6LuRcN5r+v-9oZoRwij_y+bwnUBC3ohw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm64/dts/qcom/sc7280: remove assigned-clock-rate
 property for mdp clk
To:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, quic_kalyant@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vinod Polimera (2022-02-25 07:57:49)
> Kernel clock driver assumes that initial rate is the
> max rate for that clock and was not allowing it to scale
> beyond the assigned clock value.
>
> drop the assigned clock rate property and set it
> during resume sequence with max value in the opp table.
>
> Fixes: 62fbdce91("arm64: dts: qcom: sc7280: add display dt nodes")
>

There shouldn't be a newline here. The fixes tag should be directly
attached to the SoB area.

> Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 9 ++-------

Can you also update sc7180.dtsi? Are there others SoCs that need an
update because they're using an OPP table?

Doesn't this need to come after the driver change?
