Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF087C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Feb 2022 19:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbiBITRf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Feb 2022 14:17:35 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiBITRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 14:17:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C623C001F7E;
        Wed,  9 Feb 2022 11:17:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49D496196E;
        Wed,  9 Feb 2022 19:15:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 047F5C340E7;
        Wed,  9 Feb 2022 19:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644434132;
        bh=nkrEJKDSjmn71YA63CTJjQGfPVLhZOO2Thj9DFFmk6s=;
        h=From:To:Cc:Subject:Date:From;
        b=ABbOpY+MZ2dj55AnNHP6IQYH7pujS0/qDkZ70P12N+dztSQWb6ji2Ex9MWMZ6hFF/
         CugC+Wm6+sylyB3OF0hv73GoVx8nL/dv6APJMC3INKAKPhdOfvPNCqJ6j3pTygwSLP
         lcNUZstZf9L6jprtuEUtkFJ/+gf5LAv7j1a0s6vo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com
Subject: [PATCH 5.10 0/3] 5.10.100-rc1 review
Date:   Wed,  9 Feb 2022 20:14:18 +0100
Message-Id: <20220209191248.892853405@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.100-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.100-rc1
X-KernelTest-Deadline: 2022-02-11T19:12+00:00
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 5.10.100 release.
There are 3 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri, 11 Feb 2022 19:12:41 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.100-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.10.100-rc1

Herbert Xu <herbert@gondor.apana.org.au>
    crypto: api - Move cryptomgr soft dependency into algapi

Janis Schoetterl-Glausch <scgl@linux.ibm.com>
    KVM: s390: Return error on SIDA memop on normal guest

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    moxart: fix potential use-after-free on remove path


-------------

Diffstat:

 Makefile                      | 4 ++--
 arch/s390/kvm/kvm-s390.c      | 2 ++
 crypto/algapi.c               | 1 +
 crypto/api.c                  | 1 -
 drivers/mmc/host/moxart-mmc.c | 2 +-
 5 files changed, 6 insertions(+), 4 deletions(-)


