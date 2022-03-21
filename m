Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FA2C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Mar 2022 11:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346963AbiCULx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 07:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346871AbiCULwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 07:52:40 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED88156C4D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 04:51:10 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id g16-20020a05660226d000b00638d8e1828bso10275530ioo.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 04:51:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=83x05As+hpEzsvG90JcF+MmesN/BPt2Ioqkif/dNrHk=;
        b=DzHyNTOXqd0lsa8J9+qPF6Qm2/si2WEwys7oe6i5IeKV1ygIqvSRFbBhRPkplXUQvg
         3bzX5yZyJ/qLGpNLryG02ZTCjLcDsCI5s+sIR3hB4NnOqcAPDALIgjk0ojSEttXoMgYm
         LQBR0Yi1Ux8uH3MklMUZXuFt4Zg5LAam3OVC6UF99eu0STlt7TRrjbBygSZknTKVbFTh
         IJO2fkKamkFnCoH8XfKLa8gfCR6AD/sPuurwRMXbbnklOHPlTX3dOqTRcOZOCJexXOTi
         RVcYz6jX/qofcRCN0WIZgs5arOV4Kpp/+1Y1jV2yFPgdoKxmy1vx04FH4CRZCRrG7vMA
         djJg==
X-Gm-Message-State: AOAM531rKTxlAr8P9sQ0TAeWxBo1qkmyAqYaUA4zFrHMvP5XAZp2L/vW
        G6ZE/5y3egXDky1bb6JBYvK06nPHL+ZN6OSybe7hUs9qeohe
X-Google-Smtp-Source: ABdhPJx14oK7C0sSXYkXvGjnk1LhI7Nd7dI8dHsjz4cUx21fQNuejsWZo8ywfyvHHwBn1WhJ1G6ZfQQvui4PEZ82btWAzDlAb8dg
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3816:b0:31a:60:22c9 with SMTP id
 i22-20020a056638381600b0031a006022c9mr9837348jav.146.1647863469476; Mon, 21
 Mar 2022 04:51:09 -0700 (PDT)
Date:   Mon, 21 Mar 2022 04:51:09 -0700
In-Reply-To: <1019067.1647862887@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bc8eaf05dab91c63@google.com>
Subject: Re: [syzbot] memory leak in keyctl_watch_key
From:   syzbot <syzbot+6e2de48f06cdb2884bfc@syzkaller.appspotmail.com>
To:     dhowells@redhat.com, jarkko@kernel.org, jmorris@namei.org,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+6e2de48f06cdb2884bfc@syzkaller.appspotmail.com

Tested on:

commit:         c82efd1d watch_queue: Actually free the watch
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=7683c993c23430bc
dashboard link: https://syzkaller.appspot.com/bug?extid=6e2de48f06cdb2884bfc
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
