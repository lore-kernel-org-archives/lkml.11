Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897F1C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jul 2022 04:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbiGRE7Y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jul 2022 00:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbiGRE7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 00:59:10 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839D313D55
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 21:59:09 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A24DD68AFE; Mon, 18 Jul 2022 06:59:06 +0200 (CEST)
Date:   Mon, 18 Jul 2022 06:59:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Liu Song <liusong@linux.alibaba.com>
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: remove useless assignment in
 nvme_pci_setup_prps
Message-ID: <20220718045906.GC21700@lst.de>
References: <1657972181-72398-1-git-send-email-liusong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1657972181-72398-1-git-send-email-liusong@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-5.20.
