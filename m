Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3168C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jun 2022 19:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbiFWT0s (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbiFWT01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:26:27 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38966B8F8;
        Thu, 23 Jun 2022 11:43:53 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id b12-20020a17090a6acc00b001ec2b181c98so3464273pjm.4;
        Thu, 23 Jun 2022 11:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5x+o6b6acSBKCR+OlclUgdvKbeKfnEVvGZgN/SxisMk=;
        b=ogxSMaBfYukB7yqyeSul/fg6OL8K+E8dJHxrmOZ5Vv95no8fiwJSsQksMTOXPWSLrJ
         3fP5vkc3KRHg0ZzEPxOMCb00lxBruhS8En7d3uPdHQ2vzbqDlH4j1rc2cb/LE1TyRYaO
         fR2AqN88RrmSiysLqzjoaA6EbhiC4IsErsA+nOwNsnwWXC9GLABTUSWRWJnl4WG+UVYC
         mBGeg8b2DiCdYSm43cx/+XrwUXv2uh7mrRkrqJ9IeGlM8N+DopLT4KbPBfQ04xWaGlif
         ZxzTUzhjMMbLBQMkbUza4mUAwjNiDrQ6mD/QzdS5H65lq1iJ05/7KuYuNX2UZKAKT0ch
         ex0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5x+o6b6acSBKCR+OlclUgdvKbeKfnEVvGZgN/SxisMk=;
        b=m8rhK/Mu2nxcdAWEQxb3LYBDZCUrO7hkWi2pEwIz1/IzyTRWyp+bJ5YIbp4dqoohVv
         VCCFKfKoCoyFGNFok6J0Vd8eDp2vG7SJifgS/Xy7lukP2lIW02pkI46qlIeGdLYqtPBA
         qhXpNi8J9KMLqptMfd/xiJMEV6azlaQwLur4Q7nVcDHAqnG1YTGimZlFS7IS/wSH8aqt
         Cix3sENoLbrvy20oWn3pSVfFFfieGGBV/nARUuMhxwvPxWzGNvPkIsFzXwvRoGjzxaOn
         DF4G560EbrzcgpCF8421BQurspLDxG9ER/t0JbS+r6yG8KNHPeQ8QSfLBmf+OJkeDDau
         QZbg==
X-Gm-Message-State: AJIora8TGvHA4eTZrjak532rQSVk3i3oF5LSQ0oeMbPLURMEFcnRbfNv
        wsgfbj4PMLz5dA6EYbcsToaLQQqpY0VF2MBM6Jg=
X-Google-Smtp-Source: AGRyM1u6fUWC1HBD5Vwldco5wbjMw0J9EhnIW5SrREqncelGj8x7e2mC1BtO0qFoRk3SyPMDmiH9E2xYJDrt3elNiww=
X-Received: by 2002:a17:90b:4d0e:b0:1e2:bcd7:c68c with SMTP id
 mw14-20020a17090b4d0e00b001e2bcd7c68cmr5396668pjb.74.1656009833408; Thu, 23
 Jun 2022 11:43:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220622062027.994614-1-peng.fan@oss.nxp.com> <20220622072435.GT1615@pengutronix.de>
 <CAGETcx9JpTbYtGFoKttWLeiBB73QzzBM1o-OL0o-XuFouLcEog@mail.gmail.com>
 <CAOMZO5DFX72xuxWwAPsuk4Q667Ap7Dk+pR89cWDQJkzT0D2osA@mail.gmail.com>
 <CAOMZO5Ccu_v_G9DEwrEfVHq83-hfrXCP_h20Rv0=oFTLux5AkQ@mail.gmail.com> <CAGETcx85z_hkhKFHUwnihqcD0UQG3xtSZjw=BZxqwQB0D1CMgw@mail.gmail.com>
In-Reply-To: <CAGETcx85z_hkhKFHUwnihqcD0UQG3xtSZjw=BZxqwQB0D1CMgw@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 23 Jun 2022 15:43:42 -0300
Message-ID: <CAOMZO5A6Zn=6tXU2VQ+-cj=50mpxCmoZ8c437=w1Spd34k7T6A@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mp: drop dmas property for uart console
To:     Saravana Kannan <saravanak@google.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>, hvilleneuve@dimonoff.com,
        Lucas Stach <l.stach@pengutronix.de>,
        abbaraju.manojsai@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Teresa Remmet <t.remmet@phytec.de>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, t.remmet@phytec.deh,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 3:26 PM Saravana Kannan <saravanak@google.com> wrote:

> I don't think it'll be hard to fix the console= case either. In the
> case where you are not using stdout-path, how are you setting the
> console? Just want to make sure I'm handling that case too.

When stdout-path is not passed in DT, then the bootloader needs to pass
console=ttymxc0,115200, for example.

Please copy me in v3 if you send it.

Thanks
