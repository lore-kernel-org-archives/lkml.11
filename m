Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6727EC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Feb 2022 05:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbiBOFbo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Feb 2022 00:31:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234163AbiBOFa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 00:30:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C65129B93;
        Mon, 14 Feb 2022 21:30:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18781613E9;
        Tue, 15 Feb 2022 05:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF009C340EC;
        Tue, 15 Feb 2022 05:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644903025;
        bh=xMwCjBn8KTRkAYxGDno6ZkqQjmItO6ADJ377dcLDy3k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C4mRSrbhmoJibD5RnnxphT9n4KS70iq6YMcm8IxwqBMBf9Pq200AH+ILuQM6QXRSy
         knwJS3UP422GrXeo634dGkkesEc+WbTlTkp3trS9Bi4gDvdbWpEkuFbR13RyRr739A
         q8UouppQg2baT0Yr53wIVG9pw18v2dTg9Wsq1QDft4xt1uOTcF6sw3yMG3S/N7yWyz
         9CAq/HnVeUo+46uPQSt164SMHXeeSiG/NYKMTaSODS3nCpphF4HVAJTyUmESrx//VT
         GLeRatmY2e+V39OIwYoVCfMr3Y3QKYVUgMrsmvKDtaTcFSd6FI/ytuDsabB7trkLLs
         QjgdZMW7BsYuw==
Date:   Tue, 15 Feb 2022 11:00:21 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     geert@linux-m68k.org, yoshihiro.shimoda.uh@renesas.com,
        laurent.pinchart@ideasonboard.com,
        wsa+renesas@sang-engineering.com, zou_wei@huawei.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] dmaengine: sh: rcar-dmac: Check for error num after
 dma_set_max_seg_size
Message-ID: <Ygs6beVaf5M+fLkK@matsya>
References: <20220111011239.452837-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111011239.452837-1-jiasheng@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-01-22, 09:12, Jiasheng Jiang wrote:
> As the possible failure of the dma_set_max_seg_size(), it should be
> better to check the return value of the dma_set_max_seg_size().

Applied, thanks

-- 
~Vinod
