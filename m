Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9652C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Apr 2022 12:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345889AbiDAMdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Apr 2022 08:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345861AbiDAMdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 08:33:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3E8188A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 05:31:41 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6BB141FCFF;
        Fri,  1 Apr 2022 12:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648816300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cP5GUDWML73h6kuyRp+hR2t4fRQn3Mfk1Ujn3Y5Be1o=;
        b=KKxoiQfV81wR/8BIfKlrq7w9RQxMHjcFkb8pejY9nl24aMLyv6ptR9hCzZsiwlbZjz6I/S
        /vke2JjzzwO604QKGSqUz4CCOFvCNFBq/+ncfaYUhEDjpeOyqZSS7i8Bo9hUVK/p6Hk4Q4
        0w3Wcu/e/xL1gmBMZH/6HpnnSFXrOsM=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4B61BA3B92;
        Fri,  1 Apr 2022 12:31:40 +0000 (UTC)
Date:   Fri, 1 Apr 2022 14:31:39 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] MAINTAINERS: Add printk indexing maintainers on mention
 of printk_index
Message-ID: <YkbuovatudROyl4b@alley>
References: <YkRp9IhToTmTnkl7@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkRp9IhToTmTnkl7@chrisdown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-03-30 15:32:20, Chris Down wrote:
> This will primarily catch new and changed printk_index_subsys_emit
> calls, but it's also worth catching changes to other printk indexing
> infrastructure outside of kernel/printk/index.c.
> 
> This avoids churn due to missing ccs when adding new printk indexes, as
> was the case recently for the first round of the XFS printk indexing
> patches.
> 
> Signed-off-by: Chris Down <chris@chrisdown.name>
> Cc: Petr Mladek <pmladek@suse.com>

Nice trick. I was not aware of that K: entries.

I have pushed the patch into printk/linux.git, branch for-5.19.

We missed the direct 5.18 train. I will add the commit into
a printk pull request for 5.18-rcX if there is any. But I think
that it is not worth creating a pull request just with this change.

I am going to make sure that you are added into CC in the meantime.
I hope that they will add me at least ;-)

Best Regards,
Petr
