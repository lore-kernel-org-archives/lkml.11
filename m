Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76ACC19F2A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Aug 2022 12:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbiHKMKi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Aug 2022 08:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234658AbiHKMKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 08:10:33 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACD35466C
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 05:10:31 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1336668AA6; Thu, 11 Aug 2022 14:10:28 +0200 (CEST)
Date:   Thu, 11 Aug 2022 14:10:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Dennis P. Kliem" <dpkliem@gmail.com>
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: add NVME_QUIRK_BOGUS_NID for ADATA XPG
 GAMMIX S70
Message-ID: <20220811121027.GA1665@lst.de>
References: <20220811105657.9493-1-dpkliem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811105657.9493-1-dpkliem@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-6.0.
