Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE485C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Mar 2022 05:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357813AbiCYFcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Mar 2022 01:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354901AbiCYFcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 01:32:07 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB1176658
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 22:30:33 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0F99268B05; Fri, 25 Mar 2022 06:30:30 +0100 (CET)
Date:   Fri, 25 Mar 2022 06:30:29 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Tanjore Suresh <tansuresh@google.com>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] nvme: Add async shutdown support
Message-ID: <20220325053029.GA5204@lst.de>
References: <20220324214251.3057957-1-tansuresh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324214251.3057957-1-tansuresh@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If you only send me patch 3 of a 3 patch series I have no sensible
way to review it, sorry.
