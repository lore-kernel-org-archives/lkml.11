Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9138C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 May 2022 12:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240812AbiEKMBy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 May 2022 08:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240935AbiEKMBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 08:01:48 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C995C777;
        Wed, 11 May 2022 05:01:46 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id p4so2333966edx.0;
        Wed, 11 May 2022 05:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EroBR+4+YzZMdvpx+IxguHWCfHlYcF1IYuyCJnsnDAI=;
        b=pfWDHzS7ykxH1pvFB87xvTzxU09EpYY13dpXQyvt/COtYaDkrUy2lvdu5izEQ++Vfq
         8GL1RcnMzPgIpOWq8NERKzhAie6Pzv5F8ywcjcCDBeMNcvLKcyntIXwtWxWPCqy/chen
         rO7+tDPl++qHdOZ5z9Z0vbAQkeld7FZgqlOLaWsNA99mkdzG8uUs9CTTfXNRDVifb4Lf
         rNO6izn3Ih/zKsayi12MqXaBQs98lwKkw4E6apUtmNWrRcxm3U8eK7Pes4VbBjzAjRfH
         PZhlY/MU0WdDIlqRS/aiJuuj/WV09wPMooUJlsTiqEghRSjrT1m8rP+YEFx8tR+ntcAA
         3zsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EroBR+4+YzZMdvpx+IxguHWCfHlYcF1IYuyCJnsnDAI=;
        b=vsZaGux/iufpYGYgXSr55B7Q/IV29JoSwx5xj3hiNpXdxqjFFOXN3cpyGfG4HUvjfC
         VyCL1OJ8hODUQ8xYBgWk/XQgZ71nezhLTymSh8RLcfwf013vQugM8o29UZ93lcxP7kHU
         iLy/9TbMeCdgTZi8knx1qvGmUGZPiw1z6vixh7G+k7k6TM+YAVZdsP4kjjxefPERfqY3
         /NFQ0a/LyACrwv042Ni7Yzgr5OlExiIuNaayO9TuCOtBbTNcwS/1CN8lxcXetCAWC6Wr
         rZU9/X6LQCDLJNl+AhHAGU6h8Ouk51JBxaRZdr3hYtHnZeL9vh4HTJIUggKhmJlok+wH
         gGNg==
X-Gm-Message-State: AOAM531dOREsTFnVIbbOMMR6MLLACcqxjVLajxWLlUV7o0XcQ3EugRo4
        fboKxHH1GTZH5HrivWxiehwQc/HoUYp3aX9Pju4=
X-Google-Smtp-Source: ABdhPJwT6JxShg8oQEXTsxn18s9w/KmTzoY1hjJlh96DQnYfWvsSMak+R4mUBWUoEFxvJIF5GpLZoPr9LNF6aTY3ros=
X-Received: by 2002:a05:6402:35d4:b0:427:f36b:66dc with SMTP id
 z20-20020a05640235d400b00427f36b66dcmr28804690edc.77.1652270505058; Wed, 11
 May 2022 05:01:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220511115911.54960-1-max.oss.09@gmail.com> <20220511115911.54960-5-max.oss.09@gmail.com>
In-Reply-To: <20220511115911.54960-5-max.oss.09@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 11 May 2022 09:01:33 -0300
Message-ID: <CAOMZO5Chf=SAdEpPc9PnNqkEB+EP=STp3DDd6cQT_67fcc_JTQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] ARM: dts: imx6qdl-colibri: backlight pwm: Adapt
 brightness steps
To:     Max Krummenacher <max.oss.09@gmail.com>
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 8:59 AM Max Krummenacher <max.oss.09@gmail.com> wrote:
>
> From: Max Krummenacher <max.krummenacher@toradex.com>
>
> Adapt the brightness steps as the backlight doesn't light up
> for very low duty cycles.
>
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
