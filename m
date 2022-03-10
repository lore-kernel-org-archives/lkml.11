Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956FEC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Mar 2022 16:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243389AbiCJQ3e (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Mar 2022 11:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244740AbiCJQ3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 11:29:23 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6804C41C;
        Thu, 10 Mar 2022 08:28:22 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3885468B05; Thu, 10 Mar 2022 17:28:19 +0100 (CET)
Date:   Thu, 10 Mar 2022 17:28:18 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Huang Pei <huangpei@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sasha Levin <sashal@kernel.org>,
        Christoph Hellwig <hch@lst.de>, stable@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [BUG] new MIPS compile error on v5.15.27
Message-ID: <20220310162818.GA4436@lst.de>
References: <D148EFBD-55E0-449A-AD2A-12C80ABD4FC4@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D148EFBD-55E0-449A-AD2A-12C80ABD4FC4@goldelico.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please fix <asm/asm.h>.   The most trivial fix might be to only defined
END() under __ASSEMBLY__, although in the long run it probably wants a
better name as well.
