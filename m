Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FA2C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Mar 2022 10:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238293AbiCNKEV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Mar 2022 06:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238284AbiCNKEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 06:04:16 -0400
Received: from mail.wilcox-tech.com (mail.wilcox-tech.com [45.32.83.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E40EB1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 03:03:05 -0700 (PDT)
Received: (qmail 5988 invoked from network); 14 Mar 2022 10:03:03 -0000
Received: from localhost (HELO smtpclient.apple) (AWilcox@Wilcox-Tech.com@127.0.0.1)
  by localhost with ESMTPA; 14 Mar 2022 10:03:03 -0000
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [BUG] arm64/m1: Accessing SYS_ID_AA64ISAR2_EL1 causes early boot
 failure on 5.15.28, 5.16.14, 5.17
From:   "A. Wilcox" <awilfox@adelielinux.org>
In-Reply-To: <1f0b74caa45a1d73af68eab8dcc15485@misterjones.org>
Date:   Mon, 14 Mar 2022 05:03:02 -0500
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <2498FEAE-DE38-46C5-A50A-93396BB0938A@adelielinux.org>
References: <32EA0FE1-5254-4A41-B684-AA2DEC021110@adelielinux.org>
 <Yi7iRSHaFGsYup1p@kroah.com>
 <1f0b74caa45a1d73af68eab8dcc15485@misterjones.org>
To:     Marc Zyngier <maz@misterjones.org>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 14, 2022, at 4:08 AM, Marc Zyngier <maz@misterjones.org> wrote:
> On 2022-03-14 06:35, Greg KH wrote:
>> On Sun, Mar 13, 2022 at 10:59:01PM -0500, A. Wilcox wrote:
>>> Hello,
>>> I’ve been testing kernel updates for the Adélie Linux distribution’s
>>> ARM64 port using a Parallels VM on a MacBook Pro (13-inch, M1, 2020).
>>> When the kernel attempts to access SYS_ID_AA64ISAR2_EL1, it causes a
>>> fault as seen here booting 5.17.0-rc8:
> 
> […]
> 
>>> This is because detection of the clearbhb instruction support requires
>>> accessing SYS_ID_AA64ISAR2_EL1. Commenting out the two uses of
>>> supports_clearbhb in the kernel now yields a successful boot.
>>> Qemu developers seem to have found this issue as well[1] when trying to
>>> boot 5.17 using HVF, the Apple Hypervisor Framework. This seems to be
>>> some sort of platform quirk on M1, or at least in HVF on M1. I’m not
>>> sure what the best workaround would be for this. SYS_ID_AA64ISAR2_EL1
>>> seems to be something added in ARMv8.7, so perhaps access to it could be
>>> gated on that.
>>> Unfortunately, this code was just added to 5.15.28 and 5.16.14, so
>>> stable no longer boots on Parallels VM on M1. I am unsure if this
>>> affects physical boot on Apple M1 or not.
>> What commit causes this problem?  It sounds like you narrowed this down
>> already, right?
> 
> This really is a Parallels bug. These kernels run fine on bare metal
> M1 and in KVM. QEMU was affected as well, and that was fixed in their
> HVF handling. HVF itself is fine.
> 
> So this should be punted back to the hypervisor vendor for not properly
> implementing the architecture (no ID register is allowed to UNDEF).
> 
>        M.
> -- 
> Who you jivin' with that Cosmik Debris?

Thanks, I wasn’t able to test native boot.  Since this is a bug in the hypervisor, I’ll notify them in the morning.

For those of us stuck with Parallels, I’ll assume reverting of these three commits in my own build is the best way forward until it’s fixed.  The M1 isn’t going to grow new instruction support in the meantime, so I don’t see a whole lot of harm in it - but the other mitigations in .28 seem useful.

Best,
-A.
