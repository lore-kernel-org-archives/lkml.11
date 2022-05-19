Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73C1C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 19 May 2022 17:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243156AbiESRuN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 May 2022 13:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243422AbiESRto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:49:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48422D028E;
        Thu, 19 May 2022 10:49:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD8CA61913;
        Thu, 19 May 2022 17:49:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFAB8C385AA;
        Thu, 19 May 2022 17:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652982545;
        bh=ac9xGH+1JIcnCHzru2IWbkDZOfZZiXdeXvfoHhLdoqM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=spOW840KGB04EbAqRHdAwCEI4ueJigujG10gmrQZoJohM6H/G5k95LoEo8lMQIRUG
         kb5EgjV5RPlKUXKLzXwJlYXAPbrzUmvcCpkIsEy9yT7mj+kqsXctQyxtnyDoGSfPPR
         vGw9oRS1FSIl4okTHuPOQ27P3GZJb0Bmt537RCgrscZRYwICzTULien/6Av1HMM1Uf
         DuduX7Auy6kWgTAouMt+V/zK487LrCXmjI70yWCZx+rim2RgcJnonMLLim/HxoXn44
         3WcpcMhtBuuWBLGbev6CQvd8UXSbD2uoT8OpUBO9XydaZDIF6ZBHFHOQdVtSh4Y7aM
         KjdTCTo/HfA6A==
Date:   Thu, 19 May 2022 23:19:00 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] STM32 DMA pause/resume support
Message-ID: <YoaDDFtLBjFWAJoQ@matsya>
References: <20220505115611.38845-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505115611.38845-1-amelie.delaunay@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-05-22, 13:56, Amelie Delaunay wrote:
> This patchset introduces pause/resume support in stm32-dma driver.
> [1/4], [2/4] and [3/4] ease the introduction of device_pause/device_resume
> ops management in [4/4].

Applied, thanks

-- 
~Vinod
