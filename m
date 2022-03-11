Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80870C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Mar 2022 07:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236060AbiCKHER (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Mar 2022 02:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240403AbiCKHEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 02:04:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A6013F53;
        Thu, 10 Mar 2022 23:03:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 083C8B828A1;
        Fri, 11 Mar 2022 07:03:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30438C340E9;
        Fri, 11 Mar 2022 07:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646982187;
        bh=zo3aBJFcO30JWZqIydxPZlNDKixspfDGWo9Vc+kxfrg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xesji92rSNSRvpFN42bEMBKwy/jrIbwLMigRlqhUwnLEtmACCi41wta82ypHVuiWG
         dotq1V4GsNnXrvravyL9+nph1XVGYilGkTIp7Nc7uYQWEtkwX0GLr8w7JeKcjsdvsX
         TGhUG/DdZYzp5p19axEFMaiiJNE2VYDgLSB1DaOqkdc1Cu9ozZxt6EjQnzCtC3OYMz
         rdDh9M6LVWq0PoF9RvewPscP6NGBpUbKKz556Rd6sTY7xzjqjTD8xtxbUxKUX1ebX+
         eU/SfCMfjq2Y9+FcyJScz+d1o4o4DMPJYSXrZuoMafD7DnRo4dJ7wCvDJlFBNf4Tai
         HWHXzEVRVh0bQ==
Date:   Fri, 11 Mar 2022 12:33:03 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/2] dmaengine: ti: k3-udma: Add support for AM62x SoC
Message-ID: <Yir0Jwmwdwd92X7n@matsya>
References: <20220219083220.489420-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220219083220.489420-1-vigneshr@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-02-22, 14:02, Vignesh Raghavendra wrote:
> Add AM62x SoC specific data for k3-udma driver
> 
> TRM: https://www.ti.com/lit/pdf/spruiv7

Applied, thanks

-- 
~Vinod
