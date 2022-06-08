Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FE3C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jun 2022 19:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235475AbiFHTyN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jun 2022 15:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbiFHTyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 15:54:11 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F304511907F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 12:54:08 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id n19-20020a056602341300b0066850b49e09so10285844ioz.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 12:54:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=0OeAoBi1AM006qMa6gi5ESl/HKhls9r/zBpKmobFxPY=;
        b=RlV393Gg92GgS86t+K2qAjwCrSXK3ahazlwowvNRknHLxFcG8MVkIBIGtIr8uFx1uD
         Ba/weVGNHzPfnTzExbJhsQxExHv8COEvh11CNFHDamg3gAZh1C1/83TdYu08PQAGHzmL
         SBfnfEvE65KjnQZXdh5BGrmdUfPO0oZQUugNsHo07BdLVijmzhaFDeydztHFrGqqIOIq
         caWLct1XneXUn6fj+T4HbxI3xWzSSUm26J+ZQ38D9rGqDKywTASBSzKqswlgr/9U0JY0
         gfWLvqhIwj2i05dtUf2FyfNxZQe8PSxCLQqnJ4/mMjZPDhiMrTMAVcikYzqpM1wWHR9F
         yHWw==
X-Gm-Message-State: AOAM530kdWhq4teUvsingURQq6kFAxTAQLtDcODusFC+OT4fEbIWuD2/
        0jiRmpbzRs+zWjxoWWNWNjlQaryx6kvRIKOXbgHDpZ4v3+Dd
X-Google-Smtp-Source: ABdhPJx334v5M/pzSg3M2hwpIihvwpqwcKQSqIv8ubGKndNqUS2dJ2D7KBKuHOTabqJO9t+8nKzBI0HiGGMJUws73HXWJfjb478a
MIME-Version: 1.0
X-Received: by 2002:a92:d706:0:b0:2d7:3543:75f with SMTP id
 m6-20020a92d706000000b002d73543075fmr1050044iln.146.1654718048115; Wed, 08
 Jun 2022 12:54:08 -0700 (PDT)
Date:   Wed, 08 Jun 2022 12:54:08 -0700
In-Reply-To: <YqD6Z7d5g8e19WO+@casper.infradead.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007622b805e0f511d9@google.com>
Subject: Re: [syzbot] memory leak in xas_nomem
From:   syzbot <syzbot+9e27a75a8c24f3fe75c1@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+9e27a75a8c24f3fe75c1@syzkaller.appspotmail.com

Tested on:

commit:         fe9b8137 mm/folio-compat: Remove migration compatibili..
git tree:       git://git.infradead.org/users/willy/pagecache.git for-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=b854a35bf8e4a51f
dashboard link: https://syzkaller.appspot.com/bug?extid=9e27a75a8c24f3fe75c1
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
