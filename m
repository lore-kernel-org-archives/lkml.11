Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E64EC433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Feb 2022 19:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbiBITPK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Feb 2022 14:15:10 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbiBITPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 14:15:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D73C002173;
        Wed,  9 Feb 2022 11:14:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32518B82383;
        Wed,  9 Feb 2022 19:14:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56EFEC340E7;
        Wed,  9 Feb 2022 19:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644434094;
        bh=C6lblFTHkQRXUAvXKxZipwAdPPP6Zde1k/oBH1a44rc=;
        h=From:To:Cc:Subject:Date:From;
        b=acnG1mPk/0IDcZ7k5sha3XsQbjMOCmV2HoZ2BSz2HsjbiUSEU5fvmm0F70DVxy9Mw
         YESYSyYrnHxSIaioeMFG+XhQvkXE0vkD6hc/uE3LqKqMxCbX2BUWO4wmgKDiSeomJ7
         8DL0P6vkTL/DCZD/4GQ6NR8wg+QYT334FIex3LgA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com
Subject: [PATCH 4.9 0/2] 4.9.301-rc1 review
Date:   Wed,  9 Feb 2022 20:13:31 +0100
Message-Id: <20220209191247.830371456@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.301-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.301-rc1
X-KernelTest-Deadline: 2022-02-11T19:12+00:00
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.9.301 release.
There are 2 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri, 11 Feb 2022 19:12:41 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.301-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.301-rc1

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    moxart: fix potential use-after-free on remove path

Eric W. Biederman <ebiederm@xmission.com>
    cgroup-v1: Require capabilities to set release_agent


-------------

Diffstat:

 Makefile                      |  4 ++--
 drivers/mmc/host/moxart-mmc.c |  2 +-
 kernel/cgroup.c               | 26 ++++++++++++++++++++++++++
 3 files changed, 29 insertions(+), 3 deletions(-)


