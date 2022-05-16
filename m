Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A2EC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 16 May 2022 14:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244678AbiEPOt0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 May 2022 10:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244676AbiEPOtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 10:49:22 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F513A1AB
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 07:49:17 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id g17so2729526wrb.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 07:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RKsGvNFA2armYhQ1TT2f4Esy5HeTthcwZCKQd7cnxcQ=;
        b=zdSm7SK71AbVXfd5KB4ucnRBnDAzDFZcXmlvvpTjVOKOBWRfu2qFfAGUHgoSiAutFI
         aQrwDxBfgC/n07ppsGMDCgq33Qk/av2ka/2li/6AGgI3oLRc1Hd1uVMMijIxnJ38dTKS
         kNNkpWrm++HfKKe/ZaQKAGTdgMC0fD+5krlsItJ22xh40VXVIiyziLAyZZNHBHtbCE5q
         Uq4w76G+PmWJzMQv6uBQfH48zZwrawHflPLEiNgTIcwDdmygKtvAQAQDcPlw0oHNI2ux
         Rtxj/AF68ogLnxHoW/pEsmo8ohg2EGacgjA+8VTCVgsJAJVCvBs8/lBfoQ0LBYB062b7
         0Y2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RKsGvNFA2armYhQ1TT2f4Esy5HeTthcwZCKQd7cnxcQ=;
        b=ogTcP1ur5s3RpqaFfhR6NgrPEFehxRhU3qEpNi5eLdgEhwfkr2T8jUO3spCNX7Z6K6
         yNc82iV30331HHXD7XpLysaDJGlwpbGwX7tXh5S8C/U3QJdaaiiZ6blSvKUoSi3t/iWA
         tN4wQkgL7kEdKCjvrSvbxE0yVPwOk/5F/iH+DZiJ1Q/IjeZ1dojShQXVNkqq9/yAiK4f
         xxGIibVml3cJ0dsQw1MKE+l+WEQ1I8xjiqWJHE4ZmCyl5R/ODWFE7hMs45AgWSdpfQay
         a+kNJjmhgQuaO2rn6fN3RbcnMrv/DME9j5Vltnqa1xEQtRioSaSE1rhr7SIyNq8HT5W5
         duBw==
X-Gm-Message-State: AOAM532DRtqCnH5M2FWGy/ptiMMlp2+MxYwD8BFjrFA2eudnVn2hBep0
        ShpGdwBjPHpbloDtRUKT4eDP3uN//6Bddg2wN0xWwHn2oLM=
X-Google-Smtp-Source: ABdhPJxC+K2naQi2DGX/i3KZbfX6I8NNh+s+VoQewl4Q/1OR88cxBmM4LvcZMiiESkdDM0YoM0y/lwBv/04jAYEkQSY=
X-Received: by 2002:a5d:64a6:0:b0:20c:64ef:c9cc with SMTP id
 m6-20020a5d64a6000000b0020c64efc9ccmr15445043wrp.190.1652712555819; Mon, 16
 May 2022 07:49:15 -0700 (PDT)
MIME-Version: 1.0
References: <72c973da5670b5ae81d050c582948894ee4174f8.1634206453.git.michal.simek@xilinx.com>
In-Reply-To: <72c973da5670b5ae81d050c582948894ee4174f8.1634206453.git.michal.simek@xilinx.com>
From:   Michal Simek <monstr@monstr.eu>
Date:   Mon, 16 May 2022 16:49:04 +0200
Message-ID: <CAHTX3dKRRvN+3eAa1Yz5WZJfByGPhLFOA7padA7bZp41-3magA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: gpio: zynq: Add missing compatible strings
To:     LKML <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git <git@xilinx.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C4=8Dt 14. 10. 2021 v 12:14 odes=C3=ADlatel Michal Simek
<michal.simek@xilinx.com> napsal:
>
> "xlnx,zynqmp-gpio-1.0", "xlnx,versal-gpio-1.0" and "xlnx,pmc-gpio-1.0"
> compatible strings were not moved to yaml format. But they were in origin
> text file.
>
> Fixes: 45ca16072b70 ("dt-bindings: gpio: zynq: convert bindings to YAML")
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>
>  Documentation/devicetree/bindings/gpio/gpio-zynq.yaml | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-zynq.yaml b/Docu=
mentation/devicetree/bindings/gpio/gpio-zynq.yaml
> index 378da2649e66..980f92ad9eba 100644
> --- a/Documentation/devicetree/bindings/gpio/gpio-zynq.yaml
> +++ b/Documentation/devicetree/bindings/gpio/gpio-zynq.yaml
> @@ -11,7 +11,11 @@ maintainers:
>
>  properties:
>    compatible:
> -    const: xlnx,zynq-gpio-1.0
> +    enum:
> +      - xlnx,zynq-gpio-1.0
> +      - xlnx,zynqmp-gpio-1.0
> +      - xlnx,versal-gpio-1.0
> +      - xlnx,pmc-gpio-1.0
>
>    reg:
>      maxItems: 1
> --
> 2.33.1
>

Applied.
M

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
