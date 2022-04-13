Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B588C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Apr 2022 05:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbiDMFiD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Apr 2022 01:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiDMFiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 01:38:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9521C91C;
        Tue, 12 Apr 2022 22:35:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6DD4DB8207A;
        Wed, 13 Apr 2022 05:35:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5680C385A6;
        Wed, 13 Apr 2022 05:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649828139;
        bh=f7GXNPCmUtgalYl6WVFe7K73J/3zGtgINJH6lYOkQSI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sSAnccwllYEMJZFwbj80AmRsb8QqJk4AcIwfOfH9mYgiTOdTaUYmu+9SyVfiTDJC/
         cSJj2+AeT2rcaPzWKUlzvuIPaH8CkD3cNqtD408HJ5xLdqH44VYaYcm1hmkxMAcux7
         EpjUoAZ0VSejnLVQ/fVSj2uudUz/npFcveOHHQz4XM4NpIbJ5cHzAKokf/8tAoVUMa
         zKldF6oPxUo2jino6Hdf0/I+UWEB27o3355l1m55UX6sdZxbQNaVjKGQsaQ+JfAXkc
         IF5RL2GTh3Z937M7BiQ7YiWFzhxppTfzwIQ81J7reQbaSucTUGdGvCz7MxvaU3YFrO
         JY9K/hcVtVvsw==
Date:   Wed, 13 Apr 2022 11:05:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: defconfig: Enable Qualcomm GPI DMA Driver
Message-ID: <YlZhJhY16jNvC7pn@matsya>
References: <20220225044033.1376769-1-vkoul@kernel.org>
 <YhhwEaPdyUcHBL+V@builder.lan>
 <Yhhywyf2ms44Lec2@matsya>
 <YlYzlmlKUAOBna4A@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlYzlmlKUAOBna4A@builder.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-04-22, 21:21, Bjorn Andersson wrote:
> On Fri 25 Feb 00:10 CST 2022, Vinod Koul wrote:
> 
> > On 24-02-22, 23:58, Bjorn Andersson wrote:
> > > On Thu 24 Feb 22:40 CST 2022, Vinod Koul wrote:
> > > 
> > > > Qualcomm GPI DMA Driver is used for DMA transfers for Serial engines
> > > > like Geni I2C and SPI.
> > > > 
> > > > Enable this dma driver
> > > > 
> > > > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > > > ---
> > > > 
> > > > Changes in v2:
> > > >  - As dicussed with Bjorn GPI DMA is used by Serial engines SPI/I2C so we
> > > >    can make this a module rather than inbuilt
> > > > 
> > > >  arch/arm64/configs/defconfig | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > > > index 30516dc0b70e..d73913f082d7 100644
> > > > --- a/arch/arm64/configs/defconfig
> > > > +++ b/arch/arm64/configs/defconfig
> > > > @@ -948,6 +948,7 @@ CONFIG_PL330_DMA=y
> > > >  CONFIG_TEGRA20_APB_DMA=y
> > > >  CONFIG_TEGRA210_ADMA=m
> > > >  CONFIG_QCOM_BAM_DMA=y
> > > > +CONFIG_QCOM_GPI_DMA=y
> > > 
> > > Would you like me to change this to =m as I apply the patch, just to
> > > make it match changelog? ;)
> > 
> > :(
> > 
> > Crap, looks like i forgot to add and did the amend, would be great if
> > you can, or I can send a v3...
> 
> I concluded that you didn't send v3, so I fixed this and applied it.

Thanks! much appreciated... I have the v3 but looks like never sent it
:-(

-- 
~Vinod
