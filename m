Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3D4C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Jul 2022 12:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236171AbiGEMRK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Jul 2022 08:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234292AbiGEMHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 08:07:23 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3433318E03
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 05:06:11 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id p123-20020a6bbf81000000b00674f66cf13aso6657489iof.23
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 05:06:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=T/AlQSYxlkVrUbwtFGQtFES7f2HUlnqABAOSRIEkTs4=;
        b=U7HzWFE159B9dzlaO0EyyiVGZhehQtQ3OIhzT6ebjdqJDexMO3rTnaOMuEmjqR2fch
         pQBrhF8m0hJbNOX/bPtHd3fyUOvxJxPCtHHbw/zOQiJeGVoqRotR3xJx+fPx5Pf8Y7cu
         MySrez18IIK6aOIjOED9nu5/neOJeEdnou8+VIj7bAwN2EbWegeXo5a3COfIn+Mgyk+q
         XURD3N9DQeO/OAlCELVQ6GBymYhdYzqFyXUEZBpmnEPoXJDUHxV90y0XiR0ExG4k2k+q
         V01tTTrBIvM6izbfQW25T4nuBeRjo5an/fqKLcln9o+JwY5j20T92Fe6wiG3bl7E3OqL
         XK+A==
X-Gm-Message-State: AJIora9NOUSaRfXNPeK5eJeUTT/wTUBN9uQI4Aff07bhmbTwsbmFvXRC
        eD2/BZIRRrgyhxBwk+QPZAXA84y4qfXsFMsaA7/6eY8Hy5bu
X-Google-Smtp-Source: AGRyM1tqJIgNe7Xk+QmnIWMbr08/mAuscUMlZWp6SxPbHxIQFyp23OAfaKNENVjen+rFdj/xZPV72bRW62riFm0eG+WMfPF4rPm5
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4813:b0:33c:8b87:3175 with SMTP id
 cp19-20020a056638481300b0033c8b873175mr20370097jab.182.1657022770437; Tue, 05
 Jul 2022 05:06:10 -0700 (PDT)
Date:   Tue, 05 Jul 2022 05:06:10 -0700
In-Reply-To: <20220705105938.1894-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009de38405e30dad33@google.com>
Subject: Re: [syzbot] WARNING in send_packet/usb_submit_urb
From:   syzbot <syzbot+0c3cb6dc05fbbdc3ad66@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+0c3cb6dc05fbbdc3ad66@syzkaller.appspotmail.com

Tested on:

commit:         1a0e93df Merge tag 'for-linus' of git://git.kernel.org..
git tree:       http://kernel.source.codeaurora.cn/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=109a81f4080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=833001d0819ddbc9
dashboard link: https://syzkaller.appspot.com/bug?extid=0c3cb6dc05fbbdc3ad66
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=141cc000080000

Note: testing is done by a robot and is best-effort only.
