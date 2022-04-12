Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2367EC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 12:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351870AbiDLMHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 08:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352142AbiDLMCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:02:50 -0400
X-Greylist: delayed 138 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Apr 2022 03:59:56 PDT
Received: from forwardcorp1o.mail.yandex.net (forwardcorp1o.mail.yandex.net [95.108.205.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F7B7EA2E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 03:59:55 -0700 (PDT)
Received: from myt5-23f0be3aa648.qloud-c.yandex.net (myt5-23f0be3aa648.qloud-c.yandex.net [IPv6:2a02:6b8:c12:3e29:0:640:23f0:be3a])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id C90C42E0ACC;
        Tue, 12 Apr 2022 13:57:35 +0300 (MSK)
Received: from 2a02:6b8:c12:3e23:0:640:132c:43df (2a02:6b8:c12:3e23:0:640:132c:43df [2a02:6b8:c12:3e23:0:640:132c:43df])
        by myt5-23f0be3aa648.qloud-c.yandex.net (mxbackcorp/Yandex) with HTTP id VvOSPl0K10U1-vZKqNsac;
        Tue, 12 Apr 2022 13:57:35 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1649761055; bh=FrFKHbqm+gncNNr/GE7P/sCi5NUXYl6uoAtzOQJz0uw=;
        h=References:Date:Message-Id:Cc:Subject:In-Reply-To:To:From;
        b=HY0+KUA9/KG1iPaEgqtWOLMqbB6ker3H6nJ+bEKkBUyk/GDVUCriFi6FuoScIBrH6
         /zBSEZ+7cX49D7nm2UKVbrnih8PWzyX4roPO4J2rz0L7HqFWHFU79W/d4YOPFiowdj
         HMzfEthsWm2s6Ro706+uJSjgHtPKcPeDDhwdASdE=
Authentication-Results: myt5-23f0be3aa648.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: by myt5-132c43df2a33.qloud-c.yandex.net with HTTP;
        Tue, 12 Apr 2022 13:57:35 +0300
From:   Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, mingo@redhat.com
In-Reply-To: <YlVOAw9yUbivp7Ki@hirez.programming.kicks-ass.net>
References: <1649749204-186363-1-git-send-email-dmtrmonakhov@yandex-team.ru>
         <1649749204-186363-2-git-send-email-dmtrmonakhov@yandex-team.ru> <YlVOAw9yUbivp7Ki@hirez.programming.kicks-ass.net>
Subject: Re: [PATCH 2/2] x86/unwind/orc: Fix address check size for deref_stack_iret_regs
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Tue, 12 Apr 2022 13:57:35 +0300
Message-Id: <258541649761055@myt5-132c43df2a33.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Tue, Apr 12, 2022 at 10:40:04AM +0300, Dmitry Monakhov wrote:
> 
>> For historical reasons we check only IRET_FRAME_OFFSET, but this check
>> is no longer valid because we also access regs->sp field which is
>> located beyond IRET_FRAME, so it is reasonable to validate full structure.
> 
> Uuuh, what? IRET frame is:
> 
> ss, sp, flags, cs, ip
> 
> that very much includes sp.
Oh. Indeed you are right. Sorry. Please ignore this patch.
