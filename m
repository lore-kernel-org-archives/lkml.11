Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C847ECAAD1
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Aug 2022 18:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbiH0SoE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Aug 2022 14:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiH0SoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 14:44:02 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC75B7E0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 11:44:01 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-11eb44f520dso1813142fac.10
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 11:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=as1zIaqIhmzpWWQ9L0twiJL6Yx4zZ2H34OFJcpG3kX0=;
        b=L7ZvARtcpYap0ix97Ad4o6/vMBDFolaBTAdiWWSK64EVy2HmjSeCICr3JoXLpjl07D
         Elu8C2XVdHuDhad2GnMAtPj0k+m8xvgV8AJxt0In9JbjkTgPyukAkcqaFrNXSyR1KHOX
         qNmcZoj3/4FSnwB/3Tpq3kJi8nJLz7zdjaX/l96EsdIZd8X9eeECviHPIa2jIsge07Zt
         neJyexl2bvLn6TLeopDe9AN76iE4xVua9TH7G+bt/mBG+aoI6IbKXTujs3IP1SuiRjBY
         UpgYIIVcEV+NF63iBVlALS6gaJRsKov/LpTlwwfiMhcftmQOGUZ/uN/HFVnFhkR3sb42
         VPng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=as1zIaqIhmzpWWQ9L0twiJL6Yx4zZ2H34OFJcpG3kX0=;
        b=LGGPRM5OPWkxYCSITJhxb/sf0TtXkARHYTai2IVm3NCTFHZp/sgACmqhMomdU3gOJc
         V1s5uETnlRHOpmzfYJBsbJNKN8WV9KWuChCSDdv0YLmwfRjEEP+0IOTr6wG6TgwEye6P
         5AwqbCb0Pm6v6AXVAFCQ2noaYe0GpMbwvPmLiYm7Oafs0d9WMyML5AMtATAdokTl80zW
         C7LO580HUki6oj2XryTAjMuHsXi27RiBzoJ88MuEYJ4HIWISXDETgTI/NZD68o0zbLHx
         PcmhV+afq5T51CNUoYXttWJVPUHDzJ425Sn845LjgQoAOmH35+gDJeEfcaW9jY9xPMnf
         3r8A==
X-Gm-Message-State: ACgBeo003JIddxf4f96qjSIpIUC8sBQ9nSS5Sc3Qw5Xh5ut0vNCEUig0
        ZH6pr/+oblOdDJNZRFVRpAWI2x9K2Cc=
X-Google-Smtp-Source: AA6agR4r3XYOtsdYDz1mPh3MwnJwkBDsywmvBtYy0HeYHxtRqp38pcG9X9sEWvhbyuFs1un29dKiFA==
X-Received: by 2002:a05:6870:700f:b0:11c:fb0d:4a20 with SMTP id u15-20020a056870700f00b0011cfb0d4a20mr4390569oae.97.1661625841035;
        Sat, 27 Aug 2022 11:44:01 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id t28-20020a056870f21c00b000f5e89a9c60sm3316233oao.3.2022.08.27.11.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 11:44:00 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Sander Vanheule <sander@svanheule.net>
Subject: [GIT PULL] bitmap fixes for v6.0-rc3
Date:   Sat, 27 Aug 2022 11:41:50 -0700
Message-Id: <20220827184150.4022255-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 1c23f9e627a7b412978b4e852793c5e3c3efc555:

  Linux 6.0-rc2 (2022-08-21 17:32:54 -0700)

are available in the Git repository at:

  git@github.com:/norov/linux.git tags/bitmap-6.0-rc3

for you to fetch changes up to 5d7fef0804b0a72a7efe196cd23b438edf84726c:

  lib/cpumask_kunit: add tests file to MAINTAINERS (2022-08-24 08:35:42 -0700)

----------------------------------------------------------------
Hi Linus,

Please pull the last portion of fixes from Sander for his UP rework series.
The original patches came from -mm tree, and it was not the latest version
of the series.

That's why we need follow-ups. It fixes only a test introduced by that
series. The test fails under certain configurations.

It spent about a week in -next with no issues.

Thanks,
Yury

From Sander:

This series fixes the reported issues, and implements the suggested
improvements, for the version of the cpumask tests [1] that was merged
with commit c41e8866c28c ("lib/test: introduce cpumask KUnit test
suite").

These changes include fixes for the tests, and better alignment with the
KUnit style guidelines.

[1] https://lore.kernel.org/all/85217b5de6d62257313ad7fde3e1969421acad75.1659077534.git.sander@svanheule.net/

----------------------------------------------------------------
Sander Vanheule (5):
      lib/test_cpumask: drop cpu_possible_mask full test
      lib/test_cpumask: fix cpu_possible_mask last test
      lib/test_cpumask: follow KUnit style guidelines
      lib/cpumask_kunit: log mask contents
      lib/cpumask_kunit: add tests file to MAINTAINERS

 MAINTAINERS                             |  1 +
 lib/Kconfig.debug                       |  7 +++--
 lib/Makefile                            |  2 +-
 lib/{test_cpumask.c => cpumask_kunit.c} | 52 ++++++++++++++++++++-------------
 4 files changed, 38 insertions(+), 24 deletions(-)
 rename lib/{test_cpumask.c => cpumask_kunit.c} (58%)
