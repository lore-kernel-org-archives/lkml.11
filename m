Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE39C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Apr 2022 09:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbiD0JGX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Apr 2022 05:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234870AbiD0JGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 05:06:20 -0400
Received: from localhost.localdomain (unknown [219.141.250.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A4EC8677
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 02:02:50 -0700 (PDT)
Received: from localhost.localdomain (localhost [127.0.0.1])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTPS id 23R8ss0F006841
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 27 Apr 2022 16:54:54 +0800
Received: (from root@localhost)
        by localhost.localdomain (8.15.2/8.15.2/Submit) id 23R8sVfJ006840;
        Wed, 27 Apr 2022 16:54:31 +0800
Date:   Wed, 27 Apr 2022 16:54:31 +0800
From:   Li kunyu <kunyu@nfschina.com>
To:     elver@google.com
Cc:     ebiederm@xmission.com, keescook@chromium.org, tglx@linutronix.de,
        oleg@redhat.com, legion@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel: Optimize unused integer return values
Message-ID: <20220427085431.GB6812@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, this patch is incomplete. I have the following ideas

post_copy_siginfo_from_User32 function can change the integer return value 0 to void return type, and its caller return value is based on it. Can the return type of related function be changed to void.

If you agree with this idea, I will resend the patc
