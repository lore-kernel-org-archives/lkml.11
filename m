Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC61C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Mar 2022 23:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238734AbiCIX1X (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Mar 2022 18:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbiCIX1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 18:27:16 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C730122F77;
        Wed,  9 Mar 2022 15:26:17 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E745C2CD;
        Wed,  9 Mar 2022 23:26:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E745C2CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1646868377; bh=Wrwgt7HXDmvhrJfZQQLH8FOF8me4AXFD7djPQdhzA+Q=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=XS1pBDUp6cGTSINeE/bJ63FCmGnbpEsE8qTlo3N/SNF5OQSQqTXyC2HCHTG34UWdX
         JkIscYV6hN/F3emDII1XHgmGMnayvf7XhcQLRFx4dCEVNfEqPgCwYwiejmUMWc6t7F
         PPcdk4WIB9WLSR7S02WU/62v3YhxBanVT3sxyuguULa0T9zXRwd/C6allnDuul/Tke
         Tcc2V31aNqdgJ2Nsv3GRCSOUetmAUHVJYf5vqNuwop0POOFiP17G5Uyv6DQO0TwZQK
         MNll/Z8anQvuxexOHmhqzstk8gvmAeV4uWPH1wgyMlD+9GwpVWqAEMJxZGTULNyBBv
         TnfJ8cacrDZcQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     YI <afctgo@gmail.com>, trivial@kernel.org
Cc:     YI <afctgo@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
        Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>,
        Kalesh Singh <kaleshsingh@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Colin Cross <ccross@google.com>,
        Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: proc.rst: fix wrong time unit
In-Reply-To: <20220302161122.3984304-1-uuuuuu@protonmail.com>
References: <20220302161122.3984304-1-uuuuuu@protonmail.com>
Date:   Wed, 09 Mar 2022 16:26:16 -0700
Message-ID: <87r17a7lnr.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YI <afctgo@gmail.com> writes:

> From: YI <afctgo@gmail.com>
>
> Dear Trivial Patch Monkey, 

The trivial patch monkey has gone into retirement, I'm as close as
you're going to get.

> This commit fixes a small documentaion problem reported in
> https://bugzilla.kernel.org/show_bug.cgi?id=194593.
>
> Some fields in the file /proc/$pid/stat represent time.
> Their units are clock_t, not jiffies as stated in the documentation.
> This commit fixes https://bugzilla.kernel.org/show_bug.cgi?id=194593.

We certainly don't need to give the bugzilla URL twice; I'm not
convinced it's needed even once.  The changelog should just say what the
patch does, please.

Also, "clock_t" isn't really a unit type; what are the actual units of
the field?

> Reported-by: hujunjie

This isn't a valid reported-by line

> Signed-off-by: YI <afctgo@gmail.com>

...and the signoff need to have your full name, please.

Thanks,

jon
