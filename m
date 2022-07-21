Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E4BCCA489
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jul 2022 05:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbiGUFls (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jul 2022 01:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiGUFlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 01:41:46 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91F13DF1B
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 22:41:44 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0CE1668AFE; Thu, 21 Jul 2022 07:41:42 +0200 (CEST)
Date:   Thu, 21 Jul 2022 07:41:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nick Bowler <nbowler@draconx.ca>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Guixin Liu <kanie@linux.alibaba.com>
Subject: Re: [PATCH v2] nvme: Define compat_ioctl again to unbreak 32-bit
 userspace.
Message-ID: <20220721054141.GC20003@lst.de>
References: <20220721035735.2720-1-nbowler@draconx.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721035735.2720-1-nbowler@draconx.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-5.20.
