Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B030FC433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Apr 2022 09:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344788AbiDKJwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Apr 2022 05:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344791AbiDKJwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:52:00 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24127419B1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 02:49:16 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id i2-20020a056e021b0200b002caa8e5b597so2611175ilv.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 02:49:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=sVvRetvU66viZg03zt42J481swUWQOVgkFgrLPfYY/8=;
        b=TSsrqyGY0jhPl+0YmohKJA6mM2A2hDMUZRSdZSeoPZFAQGe8GKqmxo4+vCEWlY5GTX
         2/RS6qZiMGf49egFho9KUOWHSZdKU7jq3fF+MoSq6KfgIcJZwP69L+nMY/K0VFPvoxPm
         BJWmAe6wI7r/Wl80WAsLleXKQI7e/8VxGuKjQdWEd4uFI1xEh0YN03hgR4FnuS70FVOp
         oqQjYkRKhuOYNomcKTvLRAKzq+k2sW22NmXnNWcbQcgQTWh9FbIXz/Y6vmLnntWBvxZG
         H6SezzfycwdOFpuYDEFZQArxFosLge+kQuZUelJfA2OLIw4pVLkzT86ALOGejNZaBP+a
         rNig==
X-Gm-Message-State: AOAM533g/Afsqc3AH8lWqioGM9sk+nQNp2rzqTjeyiKD267LN8g7wI5X
        CG++oahNflcz4B07AkzLjMJgWxjCyyxm7z/sgoOXc6D//MCA
X-Google-Smtp-Source: ABdhPJya+VGlIXK8Qv5D3MtuNX7CtfRMHKNRzDlkUEXSiGRhE7Fv5uA9ytXlTU+u8AOfkoYFNe1JP+P7URjn2RXgsxZkCB59PiCe
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e7:b0:2ca:b32b:f011 with SMTP id
 l7-20020a056e0212e700b002cab32bf011mr1680425iln.284.1649670555093; Mon, 11
 Apr 2022 02:49:15 -0700 (PDT)
Date:   Mon, 11 Apr 2022 02:49:15 -0700
In-Reply-To: <000000000000b960c00594598949@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006ed28805dc5ddb07@google.com>
Subject: Re: KASAN: use-after-free Read in tc_chain_fill_node
From:   syzbot <syzbot+5f229e48cccc804062c0@syzkaller.appspotmail.com>
To:     davem@davemloft.net, gregkh@linuxfoundation.org, jiri@mellanox.com,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        stable-commits@vger.kernel.org, stable@vger.kernel.org,
        syzkaller-lts-bugs@googlegroups.com, vladbu@mellanox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bug is marked as fixed by commit:
net: core: netlink: add helper refcount dec and lock function
net: sched: add helper function to take reference to Qdisc
net: sched: extend Qdisc with rcu
net: sched: rename qdisc_destroy() to qdisc_put()
net: sched: use Qdisc rcu API instead of relying on rtnl lock
But I can't find it in any tested tree for more than 90 days.
Is it a correct commit? Please update it by replying:
#syz fix: exact-commit-title
Until then the bug is still considered open and
new crashes with the same signature are ignored.
