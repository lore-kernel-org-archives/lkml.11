Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64D0C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Mar 2022 08:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242578AbiCWIVm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Mar 2022 04:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235107AbiCWIVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 04:21:38 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784EE657A6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 01:20:09 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 79EF568B05; Wed, 23 Mar 2022 09:20:05 +0100 (CET)
Date:   Wed, 23 Mar 2022 09:20:05 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     monish.kumar.r@intel.com
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        abhijeet.rao@intel.com
Subject: Re: [PATCH] nvme-pci: Add quirk changes for Samsung X5 SSDs
Message-ID: <20220323082005.GA26611@lst.de>
References: <20220316075449.18906-1-monish.kumar.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316075449.18906-1-monish.kumar.r@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-5.18.
