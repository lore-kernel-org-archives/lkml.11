Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C199C433EF
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Feb 2022 06:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355921AbiBEGVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Feb 2022 01:21:21 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:33048 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234888AbiBEGVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 01:21:18 -0500
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 6080C15F939;
        Sat,  5 Feb 2022 15:21:17 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.16.1/8.16.1/Debian-2) with ESMTPS id 2156LFF3086298
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 5 Feb 2022 15:21:16 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.16.1/8.16.1/Debian-2) with ESMTPS id 2156LF5X368767
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 5 Feb 2022 15:21:15 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.16.1/8.16.1/Submit) id 2156LFsS368766;
        Sat, 5 Feb 2022 15:21:15 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     dlunev@chromium.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "fat: add simple validation for directory inode"
References: <20220204062232.3410036-1-gwendal@chromium.org>
Date:   Sat, 05 Feb 2022 15:21:15 +0900
In-Reply-To: <20220204062232.3410036-1-gwendal@chromium.org> (Gwendal
        Grignou's message of "Thu, 3 Feb 2022 22:22:32 -0800")
Message-ID: <8735kxx290.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/29.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gwendal Grignou <gwendal@chromium.org> writes:

> This reverts commit a3082d526f2d406d4b488e49a508a0062a23314f.
>
> The reverted commit adds check for FAT images. However, the tools used
> for creating images for the Lego Mindstrom EV3 are not adding '.' and
> '..' entry in the 'Projects' directory.
> Without this fix, the kernel can not fill the inode structure for
> 'Projects' directory.
>
> See https://github.com/microsoft/pxt-ev3/issues/980
> And https://github.com/microsoft/uf2-linux/issues/6

Looks like the bug of those tools. If you want to add the workaround for
those tools, it should not break sane format.

I.e. the workaround should at least set the directory link count to work
rmdir(2) without warnings, then should test other operations if works
well.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
