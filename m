Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18A6C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Mar 2022 14:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359330AbiCYOjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Mar 2022 10:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237056AbiCYOjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 10:39:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0423DC4E00
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 07:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648219049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=APpOKgLW/XVuuqFg3wnuG5e3Lqz2v9rBU7f5RVBpsJ8=;
        b=UQuPuF5so/pcFeVYDwXuuI7dFyFNbrb0iEssXZIZ4spUA8hdPHqVrNKvVvRDGny3HZf9S5
        Nuy1V5OhNiS9RwBmK2UNGHnxEm8G9+XEs7l0Wgju3Y+cMyzdWN0Is708YVpTSEnx/xgbKG
        j9rFZVucJhtkIxW8c2/0VeyhAQDoH94=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-oIfWOIjkMvC_G_uwpkZLcQ-1; Fri, 25 Mar 2022 10:37:27 -0400
X-MC-Unique: oIfWOIjkMvC_G_uwpkZLcQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A67D695471B;
        Fri, 25 Mar 2022 14:37:26 +0000 (UTC)
Received: from max.com (unknown [10.40.195.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 35ABC200B66E;
        Fri, 25 Mar 2022 14:37:03 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [GIT PULL] fs/iomap: Fix buffered write page prefaulting
Date:   Fri, 25 Mar 2022 15:37:01 +0100
Message-Id: <20220325143701.144731-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,=0D
=0D
please consider pulling the following fix, which I've forgotten to send=0D
in the previous merge window.  I've only improved the patch description=0D
since.=0D
=0D
Thank you very much,=0D
Andreas=0D
=0D
The following changes since commit 42eb8fdac2fc5d62392dcfcf0253753e821a97b0=
:=0D
=0D
  Merge tag 'gfs2-v5.16-rc2-fixes' of git://git.kernel.org/pub/scm/linux/ke=
rnel/git/gfs2/linux-gfs2 (2021-11-17 15:55:07 -0800)=0D
=0D
are available in the Git repository at:=0D
=0D
  https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/=
write-page-prefaulting=0D
=0D
for you to fetch changes up to 631f871f071746789e9242e514ab0f49067fa97a:=0D
=0D
  fs/iomap: Fix buffered write page prefaulting (2022-03-25 15:14:03 +0100)=
=0D
=0D
----------------------------------------------------------------=0D
Fix buffered write page prefaulting=0D
=0D
----------------------------------------------------------------=0D
Andreas Gruenbacher (1):=0D
      fs/iomap: Fix buffered write page prefaulting=0D
=0D
 fs/iomap/buffered-io.c | 2 +-=0D
 mm/filemap.c           | 2 +-=0D
 2 files changed, 2 insertions(+), 2 deletions(-)=0D

