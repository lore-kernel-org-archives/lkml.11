Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C394C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Mar 2022 20:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240587AbiCWU0F (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Mar 2022 16:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240272AbiCWU0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 16:26:04 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF0B3D48D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 13:24:34 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:38190)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nX7Wt-007dRw-6V; Wed, 23 Mar 2022 14:24:27 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:35242 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nX7Ws-0080N1-2F; Wed, 23 Mar 2022 14:24:26 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>,
        Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Daniel Walsh <dwalsh@redhat.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        Serge Hallyn <serge@hallyn.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Alexey Gladkov <legion@kernel.org>
References: <cover.1644862280.git.legion@kernel.org>
Date:   Wed, 23 Mar 2022 15:24:18 -0500
In-Reply-To: <cover.1644862280.git.legion@kernel.org> (Alexey Gladkov's
        message of "Mon, 14 Feb 2022 19:18:13 +0100")
Message-ID: <877d8kfmdp.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nX7Ws-0080N1-2F;;;mid=<877d8kfmdp.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+bc2v0BvmToXTwnCKZgjNRumB58N8N6oQ=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [GIT PULL] ipc: Bind to the ipc namespace at open time.
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the per-namespace-ipc-sysctls-for-v5.18 tag from the git tree:

  git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git per-namespace-ipc-sysctls-for-v5.18
  HEAD: 1f5c135ee509e89e0cc274333a65f73c62cb16e5 ipc: Store ipc sysctls in the ipc namespace


The per ipc namespace sysctls have been imperfect since they were
implemented.  Instead of binding to the ipc namespace of the opener of
the file the code bound to the ipc namespace of the writer of the
file.

This short series of changes addresses that old deficiency in the
code.

Alexey Gladkov (2):
      ipc: Store mqueue sysctls in the ipc namespace
      ipc: Store ipc sysctls in the ipc namespace

 include/linux/ipc_namespace.h |  37 ++++++++-
 ipc/ipc_sysctl.c              | 189 +++++++++++++++++++++++++++---------------
 ipc/mq_sysctl.c               | 121 +++++++++++++++------------
 ipc/mqueue.c                  |  10 +--
 ipc/namespace.c               |  10 +++
 5 files changed, 235 insertions(+), 132 deletions(-)

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>


Eric
