Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5402C43334
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jul 2022 11:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238216AbiGZLc0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jul 2022 07:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbiGZLcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 07:32:23 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDB427CCE
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 04:32:22 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id CB07068AA6; Tue, 26 Jul 2022 13:32:17 +0200 (CEST)
Date:   Tue, 26 Jul 2022 13:32:17 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] drivers/nvme: fix pr_warn format string
Message-ID: <20220726113217.GA2725@lst.de>
References: <20220725191751.960838-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725191751.960838-1-jcmvbkbc@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was already fixed by:

commit d6f7cd209b089553ce0217eb0091f5f5fdc654ba
Author: Christoph Hellwig <hch@lst.de>
Date:   Mon Jul 18 07:02:29 2022 +0200

    nvmet: fix a format specifier in nvmet_auth_ctrl_exponential

