Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F11C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Mar 2022 06:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbiC2G63 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Mar 2022 02:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbiC2G6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 02:58:24 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AD391ADF;
        Mon, 28 Mar 2022 23:56:42 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5A2EA68AFE; Tue, 29 Mar 2022 08:56:39 +0200 (CEST)
Date:   Tue, 29 Mar 2022 08:56:39 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-scsi@vger.kernel.org
Subject: Re: [PATCH v3] scsi: pmcraid: Remove the PMCRAID_PASSTHROUGH_IOCTL
 ioctl implementation
Message-ID: <20220329065639.GC20158@lst.de>
References: <7f27a70bec3f3dcaf46a29b1c630edd4792e71c0.1648298857.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f27a70bec3f3dcaf46a29b1c630edd4792e71c0.1648298857.git.christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, long overdue:

Reviewed-by: Christoph Hellwig <hch@lst.de>
