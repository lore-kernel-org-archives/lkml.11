Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE476C433FE
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Mar 2022 16:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359605AbiCYQUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Mar 2022 12:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238937AbiCYQUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 12:20:43 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCED953E17
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 09:19:08 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id u25-20020a5d8199000000b006421bd641bbso5383789ion.11
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 09:19:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=GxV6gxAbi2eDOFbiR9qq2NG0AMftdnkrkWT4qJHnhIE=;
        b=2pknTPJOC6dKWKEyMlDuoLrgws3J/axqTnejcobvZ8imfx7zkDklCnkC1N4dUlI8Hd
         6ABa5OZ+yg52QHk+qpMTy0kVK+jwhNdNdHzGg/OVCPR9rvs0871zcV3/v1z/FC/MUwDy
         TwytDcEslhgjqpSUhpszFSDqHom7nSiLVjbMU2j1nOp+ZJlwej9sBbur6IubPoVZlkt5
         p5cXI6cEmXWM5LuVNLnoLf1W8yJL9v8UhcshS9csdtG9jFGjo+vmEYFwDpnPHKUPhjA1
         /4W/0PN0LTps6CAANWYW/1z5qGZqp+smYCcQU0QI9fv7WILGTQkw0xNCx+c9ntK3wCBa
         rDnA==
X-Gm-Message-State: AOAM531Gsd4wjrbWLK3wDlpTOl7o0cHA0fe4P59hOGHnr7KMPbo7pPaO
        o7qqf8YQ6GMUQ1Hk6PyhcQ0/c4OWpkRY+CaqUPkhJETS8PkY
X-Google-Smtp-Source: ABdhPJxBMAHIFNV7YXMLKKn5iAiZY6oMA8roTPkqQAKbI1CrGRtgW3QwNtDtuGQt2PrbItX43elXSJJFkzclXevkmRnHcXONR8H8
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1585:b0:2c2:5b2c:e3e5 with SMTP id
 m5-20020a056e02158500b002c25b2ce3e5mr5776617ilu.76.1648225148131; Fri, 25 Mar
 2022 09:19:08 -0700 (PDT)
Date:   Fri, 25 Mar 2022 09:19:08 -0700
In-Reply-To: <1a1172db-12f6-1173-b526-89e4da00e96a@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000076e11c05db0d525d@google.com>
Subject: Re: [syzbot] general protection fault in kvm_mmu_uninit_tdp_mmu
From:   syzbot <syzbot+717ed82268812a643b28@syzkaller.appspotmail.com>
To:     bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        jmattson@google.com, joro@8bytes.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        paskripkin@gmail.com, pbonzini@redhat.com, seanjc@google.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+717ed82268812a643b28@syzkaller.appspotmail.com

Tested on:

commit:         fd4fbb99 Add linux-next specific files for 20220325
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=88d1370cc1f241e6
dashboard link: https://syzkaller.appspot.com/bug?extid=717ed82268812a643b28
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14f79871700000

Note: testing is done by a robot and is best-effort only.
