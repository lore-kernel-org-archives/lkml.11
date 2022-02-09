Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5469AC433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Feb 2022 19:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbiBITQZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Feb 2022 14:16:25 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiBITQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 14:16:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE82EC0DE7D3;
        Wed,  9 Feb 2022 11:16:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E5A161901;
        Wed,  9 Feb 2022 19:15:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2743C340E9;
        Wed,  9 Feb 2022 19:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644434115;
        bh=u0IsrV9ALtgfujnqWywbJNa/TtmEdB7HPiDx9rlf8eM=;
        h=From:To:Cc:Subject:Date:From;
        b=xlt5KRy8eNqiIJh8vw28L76DadPZF7ctaEQ7mt/Y8s4W1/2yaNOAysJAhU4LOhqK9
         Go5dIhgfm90zbbFRNByOKXoFl3+nbGN1gR8Gzw0J2jALBhTHSaECEWM3O1DcjYlLvI
         omMLwGRezLJzhAhhxegdtlzdM8LNBbT+6YfAd4VA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com
Subject: [PATCH 4.19 0/2] 4.19.229-rc1 review
Date:   Wed,  9 Feb 2022 20:14:02 +0100
Message-Id: <20220209191248.596319706@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.229-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.229-rc1
X-KernelTest-Deadline: 2022-02-11T19:12+00:00
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.19.229 release.
There are 2 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri, 11 Feb 2022 19:12:41 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.229-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.19.229-rc1

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    moxart: fix potential use-after-free on remove path

Eric W. Biederman <ebiederm@xmission.com>
    cgroup-v1: Require capabilities to set release_agent


-------------

Diffstat:

 Makefile                      |  4 ++--
 drivers/mmc/host/moxart-mmc.c |  2 +-
 kernel/cgroup/cgroup-v1.c     | 24 ++++++++++++++++++++++++
 3 files changed, 27 insertions(+), 3 deletions(-)


