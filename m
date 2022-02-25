Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E741C433FE
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Feb 2022 06:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236350AbiBYGKv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Feb 2022 01:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbiBYGKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 01:10:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3F47305E;
        Thu, 24 Feb 2022 22:10:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C238F619E8;
        Fri, 25 Feb 2022 06:10:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A499DC340E7;
        Fri, 25 Feb 2022 06:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645769415;
        bh=KjHqun70ceY4y9Hq5jQPzKS0oEJN18YZnI/4cs6MxCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=du/UUF+lpOkb1Cx5KQhNkeTYU4QJyT/NpkImGREqcGTMUF6quJEoU5Ut92Zb8kK9R
         RRCFDqJJWGkXRZ915EmkdZFlTVqrE4QrquwTq9TVs27NzoOQ8j9syqzYceM5tAnWGI
         D+zLdw5SMEglCWL4ZthlVudiEPiE0jTP0jQZuriqvGOwICJi8N/CsvIY093BjU77le
         h6ssdkSzjilAc7Zhadwqxz9h5HmIf8Fq5yBtwkwEHF+XZoHx91RrpVSTWV1XpfuzfA
         4lK3zPCjy6dtj0gt3tjZSiRfxLHBLLiQ+aAlduVzTWiI15g9TuvXbmgGhr8QCSK7UM
         z9GkvqSc9bieg==
Date:   Fri, 25 Feb 2022 11:40:11 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: defconfig: Enable Qualcomm GPI DMA Driver
Message-ID: <Yhhywyf2ms44Lec2@matsya>
References: <20220225044033.1376769-1-vkoul@kernel.org>
 <YhhwEaPdyUcHBL+V@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhhwEaPdyUcHBL+V@builder.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-02-22, 23:58, Bjorn Andersson wrote:
> On Thu 24 Feb 22:40 CST 2022, Vinod Koul wrote:
> 
> > Qualcomm GPI DMA Driver is used for DMA transfers for Serial engines
> > like Geni I2C and SPI.
> > 
> > Enable this dma driver
> > 
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> > 
> > Changes in v2:
> >  - As dicussed with Bjorn GPI DMA is used by Serial engines SPI/I2C so we
> >    can make this a module rather than inbuilt
> > 
> >  arch/arm64/configs/defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > index 30516dc0b70e..d73913f082d7 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -948,6 +948,7 @@ CONFIG_PL330_DMA=y
> >  CONFIG_TEGRA20_APB_DMA=y
> >  CONFIG_TEGRA210_ADMA=m
> >  CONFIG_QCOM_BAM_DMA=y
> > +CONFIG_QCOM_GPI_DMA=y
> 
> Would you like me to change this to =m as I apply the patch, just to
> make it match changelog? ;)

:(

Crap, looks like i forgot to add and did the amend, would be great if
you can, or I can send a v3...

-- 
~Vinod
