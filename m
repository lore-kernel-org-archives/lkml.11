Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E103C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Apr 2022 12:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235478AbiDMM1Y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Apr 2022 08:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiDMM1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 08:27:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE96752E6D;
        Wed, 13 Apr 2022 05:25:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8AF52B823ED;
        Wed, 13 Apr 2022 12:24:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A11C385A4;
        Wed, 13 Apr 2022 12:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649852698;
        bh=usSiTOLYEoHwXftqbxUG2VVFK4p83txsv4K+IrKM5YM=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=Jcjp3TKJA9LcgSZTL2gIo+MyEpqgc7zyCuwHjWYVI+i9FkUEcpZ/M6l4JlSPUBwUv
         MXcCio6g+pitlmWo+I/2sWAD5b9pOHU4lZ3anPR7fgQ0m0F4ELjJVbjx0R6qjBduhA
         NVHjyv69tsnW7Cm28Z7XoWNsoUHbZFpuCBs5M+j3/JlRMM1WKunTP6M+pnN424s6QU
         dbsokjKBwnvcsFBD0LIr870IcsYUa6usxGN8cfqbr7sHekwQ89AzHXwhhywI/zMnOG
         bR4QHH6CDuDKjc8aUaYWtXZ7WA3oCUept1JE3r3GePXHNJhlROWX21lZFo7qMEV1Fg
         bKxX1TFNsIgSg==
Date:   Wed, 13 Apr 2022 17:54:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dmaengine: qcom: gpi: set chain and link flag for
 duplex
Message-ID: <YlbBFigW0tusYsfQ@matsya>
References: <20220406132508.1029348-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406132508.1029348-1-vkoul@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-04-22, 18:55, Vinod Koul wrote:
> Newer platforms seem to have strict requirement for TRE flags which
> causes transaction to timeout. This was resolved to missing chain and
> link flag for duplex spi transaction.
> 
> So add these two flags.

Applied all, thanks

-- 
~Vinod
