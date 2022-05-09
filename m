Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B773C46467
	for <linux-kernel@archiver.kernel.org>; Mon,  9 May 2022 07:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235624AbiEIHF7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 May 2022 03:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235533AbiEIGuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 02:50:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAAA15352F;
        Sun,  8 May 2022 23:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NXqU/aWXlEJRQ0qJPG0UDAA6ajCwUtVVCzntAHnRaiA=; b=A8UyI3dyR0UMChql8GiSRtDrdG
        NhJfAe8bZH5q0+JtAhELL8B6mM1KMBMh03KRjiYG5iWh35ecaxA6qSZP3pTY6niEKlwyBnya+MRXu
        OUcmmFXOWKfCfS5i5npygLP/dSdE18dckI+xdIpn3rTI/IYtG26eLZDQV83aXUe75HcLkeDy0UVTj
        J6OfGdbhAtTdw9BhztJGloZTOnWLDblt/Sflv6pSpQyHZhHsiAjq22JQnfVXrj7V/KV3WDFZGeGEN
        YkVyvD5JYbkNfqoVw+2qJcYI6KWi9izviBWZG2wlla30ZffNX9zqiIqSurWHjxvL6BuZ5PFkyFsrq
        7ImMYZqw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnxAQ-00CkUE-D3; Mon, 09 May 2022 06:46:50 +0000
Date:   Sun, 8 May 2022 23:46:50 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jing Xia <jing.xia@unisoc.com>
Cc:     viro@zeniv.linux.org.uk, jack@suse.cz, jing.xia.mail@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] writeback: Avoid skipping inode writeback
Message-ID: <Yni42sWLMFITtfmz@infradead.org>
References: <20220505134731.5295-1-jing.xia@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505134731.5295-1-jing.xia@unisoc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 09:47:31PM +0800, Jing Xia wrote:
>  	if (!(inode->i_state & I_DIRTY_ALL))
>  		inode_cgwb_move_to_attached(inode, wb);
> +	else if (!(inode->i_state & I_SYNC_QUEUED) && (inode->i_state & I_DIRTY))

Please turn this into

	else if ((inode->i_state & I_DIRTY) &&
	         !(inode->i_state & I_SYNC_QUEUED))

to keep it a little more readable.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
