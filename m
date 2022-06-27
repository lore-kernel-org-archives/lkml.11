Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6005BC43334
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jun 2022 11:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbiF0LMh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jun 2022 07:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234482AbiF0LMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 07:12:15 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0440B64F4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 04:12:14 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id o11-20020a6bcf0b000000b0067328c4275bso5534213ioa.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 04:12:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=6COfLqQjW1RqSXCM/lKzitNMWgcaVn9uRQhsCa5GtK0=;
        b=1NuqarYV6GyC9s1swv2ASBc3WjUxHKsb6fh+zywD8SA5VhOpBOUJYpPq0InkZ4sx3M
         A6zpmLXd2LwdEG3Q1z9j7wkjCmjMQumK4bzIeuEn6mlRPU7KYE0T5K3eE7bCGT/erqyO
         8VQYfJuj7B3EiTa9EgkwfQmVjf7ion/3ZBmJAV2yq/W+Zq6Hi0LGDpVwz56jStCzWtVP
         +O5emDyYFfnf9qiDvJgUkLkyeMBbUh6aSvj7Z+1A0Hm+ZX7rrhqcQzr4WM55AXUCMGPc
         UH0sIHRYCQqkUIunPSZgVZ5wwrhXgivX8tjKL6xMqa8orqHQOJV3nt5UwmKfjLbhkYMT
         4NrQ==
X-Gm-Message-State: AJIora/CyOB2FiXLIWsC3b204MdFX1XdinAPkvWMKPjAvNCfden4F2Tb
        9srvuBaL7EcJzHnd1sjwc0IIpFWEPL/3sRJFIIqr4sL/5SMb
X-Google-Smtp-Source: AGRyM1uxgO8EN72Lfh4dcOLyQT5Nc4QEPBexGyHckPEQw7YICC4yXHOccGWgnzGEQMcXf7JkY4E8LHpcajKdzzUPcNmedQ29eFiO
MIME-Version: 1.0
X-Received: by 2002:a05:6638:218c:b0:33c:9cae:166d with SMTP id
 s12-20020a056638218c00b0033c9cae166dmr2406545jaj.223.1656328333412; Mon, 27
 Jun 2022 04:12:13 -0700 (PDT)
Date:   Mon, 27 Jun 2022 04:12:13 -0700
In-Reply-To: <20220627105336.990-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f1ceee05e26bfdaa@google.com>
Subject: Re: [syzbot] WARNING: locking bug in hfa384x_usbctlx_completion_task
From:   syzbot <syzbot+ce3408364c4a234dd90c@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+ce3408364c4a234dd90c@syzkaller.appspotmail.com

Tested on:

commit:         105f3fd2 Merge branch 'staging-octeon' of gitolite.ker..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1415cb88080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a352a56bc8822d0c
dashboard link: https://syzkaller.appspot.com/bug?extid=ce3408364c4a234dd90c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=107b1ad4080000

Note: testing is done by a robot and is best-effort only.
