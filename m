Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CE1C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Mar 2022 20:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbiCQUgR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Mar 2022 16:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiCQUgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 16:36:15 -0400
Received: from p3plwbeout23-06.prod.phx3.secureserver.net (p3plsmtp23-06-2.prod.phx3.secureserver.net [68.178.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9BC1959EC
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 13:34:57 -0700 (PDT)
Received: from mailex.mailcore.me ([94.136.40.145])
        by :WBEOUT: with ESMTP
        id UwpknH3Fjx8HrUwplnnUjh; Thu, 17 Mar 2022 13:34:57 -0700
X-CMAE-Analysis: v=2.4 cv=Mo6XV0We c=1 sm=1 tr=0 ts=62339b71
 a=7e6w4QD8YWtpVJ/7+iiidw==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=o8Y5sQTvuykA:10 a=FP58Ms26AAAA:8 a=NEAV23lmAAAA:8
 a=ryZrMDmbnnAo0_BphGwA:9
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  UwpknH3Fjx8Hr
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=linux.fritz.box)
        by smtp12.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1nUwpj-0005dN-QB; Thu, 17 Mar 2022 20:34:56 +0000
From:   Phillip Lougher <phillip@squashfs.org.uk>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        squashfs-devel@lists.sourceforge.net
Cc:     phillip.lougher@gmail.com
Subject: [ANN] Squashfs-tools 4.5.1 released
Date:   Thu, 17 Mar 2022 20:34:46 +0000
Message-Id: <20220317203446.22444-1-phillip@squashfs.org.uk>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfAQABWY7q5ZTXBs++O6iHQlLRByHuBk0QyCqXxGP8lNZr9//PemnJTk0UQT+XFhj2lMNOWSYzA5RMmjLEFYH5RftUDoRhbMEGKWCS++WEl6jg/VsZFI4
 AgIlBbdRqAogkLaLaCAga0BPcIB0CjW8QJLRr8fBFXWGKrGTzT1oXE8jD7eCilI0Dn7Zt/NZgFklOHgqSwSEN06k5NgvTeafJ6JK13gIN4udqyt08XcbdLR2
 tw7a27aXv3TRJdpU2gBvQw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm pleased to announce the release of Squashfs tools 4.5.1.
This is a point release which adds Manpages, a fix for
CVE-2021-41072, and the usual minor improvements and bug fixes.

The release can be downloaded either from Sourceforge, or GitHub.

https://sourceforge.net/projects/squashfs/files/latest/download

https://github.com/plougher/squashfs-tools/archive/refs/tags/4.5.1.tar.gz

A summary of the changes is below.

Phillip

	1. Major improvements

		1.1 This release adds Manpages for Mksquashfs(1), Unsquashfs(1),
		    Sqfstar(1) and Sqfscat(1).
		1.2 The -help text output from the utilities has been improved
		    and extended as well (but the Manpages are now more
		    comprehensive).
		1.3 CVE-2021-41072 which is a writing outside of destination
		    exploit, has been fixed.

	2. Minor improvements

		2.1 The number of hard-links in the filesystem is now also
		    displayed by Mksquashfs in the output summary.
		2.2 The number of hard-links written by Unsquashfs is now
		    also displayed in the output summary.
		2.3 Unsquashfs will now write to a pre-existing destination
		    directory, rather than aborting.
		2.4 Unsquashfs now allows "." to used as the destination, to
		    extract to the current directory.
		2.5 The Unsquashfs progress bar now tracks empty files and
		    hardlinks, in addition to data blocks.
		2.6 -no-hardlinks option has been implemented for Sqfstar.
		2.7 More sanity checking for "corrupted" filesystems, including
		    checks for multiply linked directories and directory loops.
		2.8 Options that may cause filesystems to be unmountable have
		    been moved into a new "experts" category in the Mksquashfs
		    help text (and Manpage).

	3. Bug fixes

		3.1 Maximum cpiostyle filename limited to PATH_MAX.  This
		    prevents attempts to overflow the stack, or cause system
		    calls to fail with a too long pathname.
		3.2 Don't always use "max open file limit" when calculating
		    length of queues, as a very large file limit can cause
		    Unsquashfs to abort.  Instead use the smaller of max open
		    file limit and cache size.
		3.3 Fix Mksquashfs silently ignoring Pseudo file definitions
		    when appending.
		3.4 Don't abort if no XATTR support has been built in, and
		    there's XATTRs in the filesystem.  This is a regression
		    introduced in 2019 in Version 4.4.
		3.5 Fix duplicate check when the last file block is sparse.

