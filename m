Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5AEC32772
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 16:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244231AbiHWQJ1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 12:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243671AbiHWQI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:08:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8042536B0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 05:22:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB58461349
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 12:22:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1780C433C1;
        Tue, 23 Aug 2022 12:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661257321;
        bh=oWC6MMolzL8mzh7PMJA8tGSp4WsuG+0+Jpasjy9/ME0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TrRzXGxLEbtxQWpCPLXPjDMeTaxcIo7rNVhmN2nLECz6OPIhJtfvolkRFC+SgDDI4
         CnYMg8X+vgK9lWBWfViJVKWhC59xnk+11l7It5ifSgt5TyvUkrg+F37yXJSLu3f174
         GXbrhfG7NilQUlz0QmP3saMod9IKOgdgFFt22E0Z/mbcL6JLyBWrezIlte7jE+NwDd
         VLZFrEOtB/0w5ywrj0Grl2iHXfAj7cgbQpTI2oSEMK/Afklytsu75JNT9/49r+HuaY
         R77CG0hU4hTbxzeQGqaOp8bY9ue8XNig3GU8z4N5JOH7W9aYvFd07vz8gjTVmo7Lgs
         n2WOhSbu1gB2Q==
Date:   Tue, 23 Aug 2022 15:21:48 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Rebecca Mckeever <remckee0@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 0/2] memblock tests: add command line help option and
 update obsolete comments
Message-ID: <YwTGXDFao1iEGatL@kernel.org>
References: <cover.1660451025.git.remckee0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1660451025.git.remckee0@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 14, 2022 at 12:50:18AM -0500, Rebecca Mckeever wrote:
> These patches add a help command line option to the help message and
> update references to an obsolete build option in comments.
> 
> Rebecca Mckeever (2):
>   memblock tests: add command line help option
>   memblock tests: update reference to obsolete build option in comments
> 
>  tools/testing/memblock/tests/common.c | 4 +++-
>  tools/testing/memblock/tests/common.h | 9 ++++++---
>  2 files changed, 9 insertions(+), 4 deletions(-)

Applied, thanks!
 
-- 
Sincerely yours,
Mike.
