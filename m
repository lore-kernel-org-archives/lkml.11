Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CC8C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Apr 2022 14:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351600AbiDZO3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Apr 2022 10:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351626AbiDZO3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 10:29:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E265BD06;
        Tue, 26 Apr 2022 07:25:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 911BD61839;
        Tue, 26 Apr 2022 14:25:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 659BDC385A0;
        Tue, 26 Apr 2022 14:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650983159;
        bh=l9K08w6wL5qUGA4LunV6wKDCIP41MyosKri/ltMJ6+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T4j8C/P9VbKYKxSJBJkS9QzDsM08ZUrN7v46s40tvrgIDYq3U+172EH2B/6BjeYi2
         RkjgpNp8LSlANaUILh+I/Ng6c/tk4NI/9AUFOGY/yEtBLC3ap6joEllf7VYhX5xpAn
         92pddklFBNETDs3hU3lKz14c6ZhmsCkCVyTQ4Wb3zT7HQZK1O/qKdahsfi8sX+cyuu
         FGKm+Ge2ZDO8b6+5aZmppDAz+SW9USWm1NjrXru/orHrF6qhXcA2sVmofzOeUX8qBe
         rLrUqL1AS/dd9DtPFFXtFbeX1gjZOXMX6kJW5XzXhIkt3PJNo4LliCxZ71kOi++q7W
         GWcdXinpKapVg==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19.y 0/3] ia64: kprobes: Fix build error on ia64
Date:   Tue, 26 Apr 2022 23:25:54 +0900
Message-Id: <165098315444.1366179.5950180330185498273.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <202204130102.JZPa6KCQ-lkp@intel.com>
References: <202204130102.JZPa6KCQ-lkp@intel.com>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Kernel test bot reported that the ia64 build error on stable 4.19.y because
of the commit d3380de483d5 ("ia64: kprobes: Use generic kretprobe trampoline
handler").
I also found that this commit was involved by the backporting of commit
f5f96e3643dc ("ia64: kprobes: Fix to pass correct trampoline address to the
handler"), and this 2nd commit was backported wrong way. Actually, this 2nd
commit aimed to use dereference_function_descriptor() in kprobes@ia64, but
the comment (and Fixes tag) points the 1st commit. Thus I guess this mistake
happened.

So I re-backport the upstream commit a7fe2378454c ("ia64: kprobes: Fix to
pass correct trampoline address to the handler") correctly, without involving
the 1st commit.

Thank you,

---

Masami Hiramatsu (3):
      Revert "ia64: kprobes: Fix to pass correct trampoline address to the handler"
      Revert "ia64: kprobes: Use generic kretprobe trampoline handler"
      ia64: kprobes: Fix to pass correct trampoline address to the handler


 arch/ia64/kernel/kprobes.c |   78 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 75 insertions(+), 3 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
