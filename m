Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0A2ECAAD5
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Aug 2022 05:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiH3FDK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Aug 2022 01:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiH3FDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 01:03:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F98C5246B
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 22:03:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20864B81632
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 05:03:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19571C433D6;
        Tue, 30 Aug 2022 05:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661835784;
        bh=UEGxpf5PeVt1wCUvkuPifC5GN/BTpqhuMv/zeTutc+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J4k8QZhYWyG27LiA5Jk6FMbRQoyjXL4TzBJPUE1EBFN2xfx22T8zgQSKBNEkUSesb
         9iTgQXU+6y1YNxmGQYOCYYMEueNkkOCCYMLEiGy81F7apvAk7XThYxuinVlxKDk+cz
         rEQFIfxCfze/dR3c8dMpyrR2w82G0RUWrILPeaKSicGNj/lmJ/k6LVig/BSGRhyoLt
         Vavlnewh1ZNY02yila/BDetppqG5BAWb1mT25iu+X7xBhw1qC4QDcx5iHWsxR0BZI2
         +9SFOYB81aTi68rs0tvyjTu/5bh4nTU6/6549Yn0apsik0e6kNnlRqKvQhSjDo9tuK
         /oONLP7mYU0Ww==
Date:   Tue, 30 Aug 2022 10:33:00 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: marvell: phy-mvebu-a3700-comphy: Remove broken
 reset support
Message-ID: <Yw2aBNnVoV8wwk4i@matsya>
References: <20220829083046.15082-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220829083046.15082-1-pali@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-08-22, 10:30, Pali Rohár wrote:
> Reset support for SATA PHY is somehow broken and after calling it, kernel
> is not able to detect and initialize SATA disk Samsung SSD 850 EMT0 [1].
> 
> Reset support was introduced in commit 934337080c6c ("phy: marvell:
> phy-mvebu-a3700-comphy: Add native kernel implementation") as part of
> complete rewrite of this driver. v1 patch series of that commit [2] did
> not contain reset support and was tested that is working fine with
> Ethernet, SATA and USB PHYs without issues too.
> 
> So for now remove broken reset support and change implementation of
> power_off callback to power off all functions on specified lane (and not
> only selected function) because during startup kernel does not know which
> function was selected and configured by bootloader. Same logic was used
> also in v1 patch series of that commit.
> 
> This change fixes issues with initialization of SATA disk Samsung SSD 850
> and disk is working again, like before mentioned commit.
> 
> Once problem with PHY reset callback is solved its functionality could be
> re-introduced. But for now it is unknown why it does not work.

Applied, thanks

-- 
~Vinod
