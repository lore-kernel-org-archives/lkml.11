Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEDEC4332F
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Feb 2022 21:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242669AbiBWVW1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Feb 2022 16:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242639AbiBWVVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 16:21:14 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5B94ECE8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 13:20:46 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id vz16so206436ejb.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 13:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=xd4LvKHiHUPDGiBy1ONlwJ4pI3s5n346dQjnITOJk1o=;
        b=xQ22s0WGk0cnWEzyu3Z0C+NhgsaXR6XN49m3BG6ZFy21Efz/z+w4imfrJnwBggOiO2
         PyELXYJuw3AA250SLygrE6xT6eVoy7hGoOps/fgk2wX9KqJ3iWD4hk6dGYoYHcCvmeRm
         VUpdodaKNaU7/eixnrz3eFulGgB/68GL1vOe+GioKdVHQqXK95bzNNpfLi+zETgXdnBb
         i7pk0QBtXRb20UR8uFTPqdg0GN8WP1+i0R93XhvdLuk2OX147jl19mBGx+OjstIrzmz+
         jIuV4sXFOyKaiM4JnOqkjLhY5Ze7ivxVM1AZ4VS+gBAjbyBR0jL7PpgdkiVKgrrGOPiA
         2BQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=xd4LvKHiHUPDGiBy1ONlwJ4pI3s5n346dQjnITOJk1o=;
        b=Me85VIgeqbXPAPe4/W7xiyLJ4t+j2AF8/G+GQcsWnVwAYzsyY/QFMqhzxwlg26OW0J
         +pFaR9XqixvLw6LVtvFIUZi7jIrD5RGiOE5v23+F2VDTeZbx5D3U+BilE6I9Muw6Fo+p
         K5Sw72lhqR1U+y2/Im54vZNI2QihQ07/46sYSA4fy4rvOqrKufgchYH2H1IPGz7CDd0B
         jkvfFluhAANPqGqIwkahjXnntxS1kn5jwV14XB9+TLdd6O/OSaKYFy4/7IM49w44Dfce
         jqgeze+D2LJd6fwD0XgzsXVJFQF56S7DWPW+OXPcPAawinsNunJCYUFq5E52ilY5pu3w
         10GA==
X-Gm-Message-State: AOAM532TN8b+Oa+K7/VP4Ku3QFy4pCuAN6Udyq9hlheU4PG6GKqEh7zg
        yh26IU6HKFc4LvaJ2aPjtKJ+5ISuBssDppDfKeLnSQJMr0W4
X-Google-Smtp-Source: ABdhPJw/xI5NIoA2cvzfMoAwTJwB8wjkmPHDZGo0B0KxKeO/CG7lV35mThYgzY446LXM569kA0nuWPqJCsPpNpPFuCg=
X-Received: by 2002:a17:906:c318:b0:6cf:d118:59d8 with SMTP id
 s24-20020a170906c31800b006cfd11859d8mr1194550ejz.112.1645651244646; Wed, 23
 Feb 2022 13:20:44 -0800 (PST)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 23 Feb 2022 16:20:33 -0500
Message-ID: <CAHC9VhQHW1UOfu5wDOnNHwTK7FF4SyTx1OCBd9o6izB+69H9EQ@mail.gmail.com>
Subject: [GIT PULL] SELinux fixes for v5.17 (#2)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

A second small SELinux fix for v5.17-rcX which addresses an incorrect
mutex_is_locked() check; the commit description provides more detail
if desired.  Please merge for the next -rcX release, thanks.

-Paul

--
The following changes since commit 186edf7e368c40d06cf727a1ad14698ea67b74ad:

 selinux: fix double free of cond_list on error paths
   (2022-02-02 11:02:10 -0500)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20220223

for you to fetch changes up to ce2fc710c9d2b25afc710f49bb2065b4439a62bc:

 selinux: fix misuse of mutex_is_locked() (2022-02-22 18:02:58 -0500)

----------------------------------------------------------------
selinux/stable-5.17 PR 20220223

----------------------------------------------------------------
Ondrej Mosnacek (1):
     selinux: fix misuse of mutex_is_locked()

security/selinux/ima.c | 4 ++--
1 file changed, 2 insertions(+), 2 deletions(-)

-- 
paul-moore.com
