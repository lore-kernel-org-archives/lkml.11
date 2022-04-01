Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3EDC433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Apr 2022 13:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346460AbiDANli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Apr 2022 09:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346450AbiDANle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 09:41:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B4E53377F8
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 06:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648820383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h6NQyMqLB58mw6AkprjfrT2eMsB7dX14dgGFHiYBaig=;
        b=Te19cyqTItTb52oZEDD3sn2FbFExWtyZDX9jMIg6oN91xyskJ2/Gk+Wk6QBgOnzY1wV8N7
        zeaanDsJx+1n+Ef/2oaD7x2dJ3IfrMOvUcsc52zxzd3CNq7Bu+3Fm6quJnBaZT6zmVGcHy
        jvYp1wp0R7Iht0hB82Ac2IykXvwBSmM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-450-nL7KlP4-Pv-1HD6HzTPi4A-1; Fri, 01 Apr 2022 09:39:40 -0400
X-MC-Unique: nL7KlP4-Pv-1HD6HzTPi4A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0E27B101AA64;
        Fri,  1 Apr 2022 13:39:40 +0000 (UTC)
Received: from x2.localnet (unknown [10.22.11.39])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6157342CFE9;
        Fri,  1 Apr 2022 13:39:39 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>, linux-audit@redhat.com,
        CGEL <cgel.zte@gmail.com>
Cc:     kbuild-all@lists.01.org, Zeal Robot <zealci@zte.com.cn>,
        linux-kernel@vger.kernel.org, eparis@redhat.com,
        dai.shixin@zte.com.cn, Yang Yang <yang.yang29@zte.com.cn>,
        linux-audit@redhat.com, ink@jurassic.park.msu.ru,
        huang.junhua@zte.com.cn, guo.xiaofeng@zte.com.cn,
        mattst88@gmail.com
Subject: Re: [PATCH] audit: do a quick exit when syscall number is invalid
Date:   Fri, 01 Apr 2022 09:39:38 -0400
Message-ID: <2777189.mvXUDI8C0e@x2>
Organization: Red Hat
In-Reply-To: <62465bf3.1c69fb81.d5424.365e@mx.google.com>
References: <20220326094654.2361956-1-yang.yang29@zte.com.cn> <CAHC9VhTaCNqfTOi8X5G3AheBFzTYCzGnt_-=fNFc5Z1o8gPm9Q@mail.gmail.com> <62465bf3.1c69fb81.d5424.365e@mx.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, March 31, 2022 9:57:05 PM EDT CGEL wrote:
> On Thu, Mar 31, 2022 at 10:16:23AM -0400, Paul Moore wrote:
> > On Wed, Mar 30, 2022 at 10:29 PM CGEL <cgel.zte@gmail.com> wrote:
> > > On Wed, Mar 30, 2022 at 10:48:12AM -0400, Paul Moore wrote:
> > > > If audit is not generating SYSCALL records, even for invalid/ENOSYS
> > > > syscalls, I would consider that a bug which should be fixed.
> > > 
> > > If we fix this bug, do you think audit invalid/ENOSYS syscalls better
> > > be forcible or be a rule that can be configure? I think configure is
> > > better.
> > 
> > It isn't clear to me exactly what you are asking, but I would expect
> > the existing audit syscall filtering mechanism to work regardless if
> > the syscall is valid or not.
> 
> Thanks, I try to make it more clear. We found that auditctl would only
> set rule with syscall number (>=0 && <2047). So if userspace using
> syscall whose number is (<0 || >=2047), there seems no meaning for
> kernel audit to handle it, since this kind of syscall will never hit
> any audit rule(this rule could not be set by auditctl).

This limit is imposed by:

/usr/include/linux/audit.h

struct audit_rule_data {
...
        __u32           mask[AUDIT_BITMASK_SIZE]; /* syscall(s) affected */

Where   #define AUDIT_BITMASK_SIZE 64

So, 64 * 32 = 2048

-Steve

> By the way it's a little strange for auditctl(using libaudit.c) to limit
> syscall number (>=0 && <2047)(see audit_rule_syscall_data()), especially
> we know NR_syscalls is the real limit in kernel, you can see how other
> kernel code to the similar thing in ftrace_syscall_enter():
> 
> 	static void ftrace_syscall_enter(void *data, struct pt_regs
> 	*regs, long id)
> 	{
> 		...
> 		syscall_nr = trace_get_syscall_nr(current, regs);
> 		if (syscall_nr < 0 || syscall_nr >= NR_syscalls)
> 			return;
> 		...
> 	}
> 
> Thanks.
> 
> > Beware that there are some limitations
> > to the audit syscall filter, which are unfortunately baked into the
> > current design/implementation, which may affect this to some extent.
> 
> --
> Linux-audit mailing list
> Linux-audit@redhat.com
> https://listman.redhat.com/mailman/listinfo/linux-audit




