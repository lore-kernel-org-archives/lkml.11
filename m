Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE82C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Mar 2022 13:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348621AbiCONXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Mar 2022 09:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbiCONXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 09:23:18 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1933F30F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 06:22:06 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 796F568AA6; Tue, 15 Mar 2022 14:22:02 +0100 (CET)
Date:   Tue, 15 Mar 2022 14:22:02 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Mark Hsieh <mark_hsieh@wistron.corp-partner.google.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        sagi@grimberg.me, hch@lst.de, axboe@fb.com, kbusch@kernel.org,
        alsa-devel@alsa-project.org, Mark_Hsieh@wistron.com
Subject: Re: [PATCH] [v2] nvme-pci: disable write zeros support on specific
 SSDs
Message-ID: <20220315132202.GA12452@lst.de>
References: <20220315132059.12747-1-mark_hsieh@wistron.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315132059.12747-1-mark_hsieh@wistron.corp-partner.google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 09:20:59PM +0800, Mark Hsieh wrote:
> Like commit 5611ec2b9814 ("nvme-pci: prevent SK hynix PC400 from using
> Write Zeroes command"), Micron has the same issue:
> [ 6305.633887] blk_update_request: operation not supported error, dev
> nvme0n1, sector 340812032 op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
> 
> So also disable Write Zeroes command on Micron.

This still ignores all the questions I've asked.
