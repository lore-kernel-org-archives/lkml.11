Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49251C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Jul 2022 16:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbiGAQhL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Jul 2022 12:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiGAQhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 12:37:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C952C37A3D;
        Fri,  1 Jul 2022 09:37:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8977CB83090;
        Fri,  1 Jul 2022 16:37:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5645C3411E;
        Fri,  1 Jul 2022 16:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656693426;
        bh=dvn0q53TXBDnV3Qt4aSdr2WzDOqUHtfan8BhemxpCOI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QkiDgZpOfaN9dOsDRrcDsbMySgGbQpKCeO+no3q1kSX+1cRgqA2x4iEzPdY/XW3UF
         1+2xoNv9YCEy7Q2lYD4OCwmmWsdnAYTFzcCjV1CrNKS8xmZXVPb+0Uelzf5iWfWx7g
         prCRoRfZtwtTMVw3j99tU/q+FAW+tbfcH1E/MTMPYNnmoM3XhZbgodSspBaCkRzIHH
         eXzeCb2+JRoT7Rs2YCkucN713hRlcycMY3jm5NsgaWoDCC0dtJv6efdUljoPTbJ5Oy
         v9buw0XVWJyeh4Dc2K3+zmhU0AgZLwv2zdi6fW/VbhS9zqdApMrLm9fSDidJRNrAH8
         4Eut+nwcApcRQ==
Date:   Fri, 1 Jul 2022 22:07:01 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Xiang wangx <wangxiang@cdjrlc.com>
Cc:     sean.wang@mediatek.com, matthias.bgg@gmail.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: mediatek: mtk-hsdma: Fix typo in comment
Message-ID: <Yr8ircxQa4I7/jmW@matsya>
References: <20220618130120.9783-1-wangxiang@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220618130120.9783-1-wangxiang@cdjrlc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-06-22, 21:01, Xiang wangx wrote:
> Delete the redundant word 'be'.

Applied, thanks

-- 
~Vinod
