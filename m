Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF37AECAAD1
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Sep 2022 08:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbiIAIkr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Sep 2022 04:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233358AbiIAIki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:40:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA44397507
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 01:40:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8BA8D223D9;
        Thu,  1 Sep 2022 08:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1662021633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H0QScilVtxiO5bJJE8A1A5ERc/PXpP1x62UG82vw6oY=;
        b=elM7XrD+NVr/NX9LcMpu4X/xIi1D14H9qc0yzMM+6FqSt1YY7kDszRK+rk2Wpglrc+T93D
        H6nKlMvrbkFP+U3hZKAw8hKrboKXzLwYR6xFPWRyl81CsgPMoQqUQFVi+RcoVRj5h7DQQw
        keeCdEZcOG6w2lIMz9NPXjGpkGZiPPY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6831A13A79;
        Thu,  1 Sep 2022 08:40:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id q2MHFwFwEGMSOQAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 01 Sep 2022 08:40:33 +0000
Date:   Thu, 1 Sep 2022 10:40:32 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Eric Dumazet <edumazet@google.com>,
        Waiman Long <longman@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH 3/3] mm,page_owner: Filter out stacks by a threshold
 counter
Message-ID: <YxBwAANmAAivHYA5@dhcp22.suse.cz>
References: <20220901044249.4624-1-osalvador@suse.de>
 <20220901044249.4624-4-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901044249.4624-4-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 01-09-22 06:42:49, Oscar Salvador wrote:
[...]
> +static ssize_t read_page_owner_threshold(struct file *file, char __user *buf,
> +					 size_t count, loff_t *pos)
> +{
> +	char *kbuf;
> +	int ret = 0;
> +
> +	count = min_t(size_t, count, PAGE_SIZE);
> +
> +	if (*pos >= count)
> +		return 0;
> +
> +	kbuf = kmalloc(count, GFP_KERNEL);

No, you do not want to trigger user defined allocation like that. I
would use seq_file.
-- 
Michal Hocko
SUSE Labs
