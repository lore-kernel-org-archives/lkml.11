Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB53CCA47B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jun 2022 00:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239739AbiF1Aax (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jun 2022 20:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbiF1Aau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 20:30:50 -0400
Received: from smtp01.aussiebb.com.au (smtp01.aussiebb.com.au [121.200.0.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0A7FED;
        Mon, 27 Jun 2022 17:30:49 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 5B82210053E;
        Tue, 28 Jun 2022 10:30:47 +1000 (AEST)
X-Virus-Scanned: Debian amavisd-new at smtp01.aussiebb.com.au
Received: from smtp01.aussiebb.com.au ([127.0.0.1])
        by localhost (smtp01.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QcB-4sLHZxD8; Tue, 28 Jun 2022 10:30:47 +1000 (AEST)
Received: by smtp01.aussiebb.com.au (Postfix, from userid 116)
        id 4F1FB10054D; Tue, 28 Jun 2022 10:30:47 +1000 (AEST)
Received: from donald.themaw.net (180-150-90-198.b4965a.per.nbn.aussiebb.net [180.150.90.198])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 9587E100293;
        Tue, 28 Jun 2022 10:30:46 +1000 (AEST)
Subject: [PATCH 0/2] vfs: fix a couple of mount table handling problems
From:   Ian Kent <raven@themaw.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Siddhesh Poyarekar <siddhesh@gotplt.org>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 28 Jun 2022 08:30:46 +0800
Message-ID: <165637619182.37717.17755020386697900473.stgit@donald.themaw.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First, whenever a mount has an empty "source" (aka mnt_fsname), the
glibc function getmntent incorrectly parses its input, resulting in
reporting incorrect data to the caller.

The problem is that the get_mnt_entry() function in glibc's
misc/mntent_r.c assumes that leading whitespace on a line can always
be discarded because it will always be followed by a # for the case
of a comment or a non-whitespace character that's part of the value
of the first field. However, this assumption is violated when the
value of the first field is an empty string.

This is fixed in the mount API code by simply checking for a pointer
that contains a NULL and treating it as a NULL pointer.

Second, when a filesystem is mounted with a name that starts with
a # the glibc finction getmentent() will interpret the leading #
as a comment so that the mount line will not appear in the output.

This is fixed by adding a # to the to be translated string in
fs/proc_namespace.c:mangle().

Signed-off-by: Ian Kent <raven@themaw.net>
---

Ian Kent (1):
      vfs: parse: deal with zero length string value

Siddhesh Poyarekar (1):
      vfs: escape hash as well


 fs/fs_context.c     | 10 +++++++---
 fs/proc_namespace.c |  2 +-
 2 files changed, 8 insertions(+), 4 deletions(-)

--
Ian

