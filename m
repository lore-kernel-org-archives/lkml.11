Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBADC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Mar 2022 01:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240174AbiCWBl2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Mar 2022 21:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiCWBl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 21:41:26 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2C532ED5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 18:39:58 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id n18so209083plg.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 18:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=2ueOjlq15eu7oYpfnlXkQFucNb+A7c4qBM8Kc8VaCtE=;
        b=W1URGPCPrRJ2ZZEx+kiyBzNSfX9hhFHEuQexMQTNcvyApLOu5B9QKXqB8vtKN81xa8
         RwJZe0mNGYPJ8QrW0K72E/5DnYNgE8dMWmHEtpZS21oVB+20EVrYeXVhJfyeBoHkMVJm
         aM2gftiaMc3lxYbV1gU+hdcMqE78CSHPkape7ootr92pLnKA40tu8nXeoOx4MJ9k+99P
         5xWaph0nEZGjZfz/QrUS1yA20SToq4mjlk73T/URN0MQIrpMg30itCyuMzA5NPrDHI4p
         XOckKI6B8JVDu0ec9mx70F0y30qXBNPHw6ZqzAbK8Q4xjyOolOG8bvFsjAUjuuBy3TFF
         /Yww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=2ueOjlq15eu7oYpfnlXkQFucNb+A7c4qBM8Kc8VaCtE=;
        b=0QkgGhDpCJmcDqYYQPTEsRWDZrd1cltoHRthYxspDZ6DHmY9mUlarNkPx/d0bAd6K/
         CRawzLsZnka+tWe8Yhq55Jkn9vRRGzQ/1kfd3XfX4lSCr4zihxxrCeN6tNCG16WhowAJ
         g4RcUERaAXtYiQoZUppHx5HR3wsJktASpTA33Hm24PHBhx83rPEFenit092kF3O+1CEB
         +/vLYCRBiXtqUAEetq6kDALZKRdZ9cCN3eYcfga++xUF+bJBVuRZ40S7Lv/zejDKg3IS
         Td6c2bRd5UaoG4vofPRww1i7HIxB9Rn/S8H7Mp4D6q2gURutFg0U+i0KobHPrOs5SP4l
         783A==
X-Gm-Message-State: AOAM533bQfItNUZFUyWMhq30PmMAAAAP60PWuTPbnHe28cNwizD/J2jv
        4gDteKpIigSJNsAvH9oBtOsd20aXkVZ33jsYXm6YmC5Vv8G/iQ==
X-Google-Smtp-Source: ABdhPJyCemkBbr0iy/8AAuAdcEuO1L5SWva5HC++gia6XuC8WzbURILZLfz41Bl0ZSMwmVW9iIcDOHB+zHzx9W/zsLA=
X-Received: by 2002:a17:90a:430d:b0:1bc:f340:8096 with SMTP id
 q13-20020a17090a430d00b001bcf3408096mr8379919pjg.93.1647999597006; Tue, 22
 Mar 2022 18:39:57 -0700 (PDT)
MIME-Version: 1.0
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 22 Mar 2022 18:39:49 -0700
Message-ID: <CAPcyv4iOwM+qaKdw-BPkDe9Fpc19YVezVVurZ0n0o7OsRsEuJw@mail.gmail.com>
Subject: [GIT PULL] DAX update for 5.18
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/dax-for-5.18

...to receive a small collection of dax fixes for 5.18. Andrew has
been shepherding major dax features that touch the core -mm through
his tree, but I still collect the dax updates that are core-mm
independent. These have been in Linux-next with no reported issue for
multiple weeks.

---

The following changes since commit 754e0b0e35608ed5206d6a67a791563c631cec07:

  Linux 5.17-rc4 (2022-02-13 12:13:30 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/dax-for-5.18

for you to fetch changes up to db8cd5efeebc4904df1653926102413d088a5c7e:

  dax: Fix missing kdoc for dax_device (2022-03-12 13:46:25 -0800)

----------------------------------------------------------------
dax for 5.18

- Fix a crash due to a missing rcu_barrier() in dax_fs_exit()

- Fix two miscellaneous doc issues

----------------------------------------------------------------
Ira Weiny (1):
      dax: Fix missing kdoc for dax_device

Shiyang Ruan (1):
      fsdax: fix function description

Tong Zhang (1):
      dax: make sure inodes are flushed before destroy cache

 drivers/dax/super.c | 2 ++
 fs/dax.c            | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)
