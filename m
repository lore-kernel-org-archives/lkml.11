Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CECC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 May 2022 08:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239522AbiEKIzC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 May 2022 04:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbiEKIyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 04:54:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDC2232770
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 01:54:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9DD9CB82144
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 08:54:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B4AC340EB;
        Wed, 11 May 2022 08:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652259289;
        bh=Yb3MAYFk9Yi9xQ3U4krUF9K+QBSMz8vdE+dZbdTZ3y8=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=SeQi0tEt3GQMDQ/VIbBaZKep/ONNI381zhrA7M+b+H+mJbzS7JV8O6tKphzRc3CK7
         2l/Ft8zPpMHqWnjG7Ij17pbC4MCOKex3OZISe9XJtupjJ7wskBkvNBUytliIcMMufp
         zEA/39jXTmSp7qoQdwr1oPDMLb9c1zVbSjJl6BwtWqci2Tj74QbMeA3cMIjJAsWuxP
         eZAx4szrkue6kOjZ2G8zedEG6JkBA3p1akK7MUlg/w1doX7CTQ+NJoK1lhyIGu+ISM
         x38tL/ygtePNU4euH21OsrJS8SJwXil4mwsaRaqlP6O96J0nEOzZsRN4LuTyv74+PU
         2EGhT/lP73R4w==
Message-ID: <a1b7c4e9-53f2-aa51-4aea-4a530b731a56@kernel.org>
Date:   Wed, 11 May 2022 16:54:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [f2fs-dev] [PATCH 2/5 v2] f2fs: introduce f2fs_gc_control to
 consolidate f2fs_gc parameters
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20220506232032.1264078-1-jaegeuk@kernel.org>
 <20220506232032.1264078-2-jaegeuk@kernel.org> <YnlFiz/IgsjtGhqu@google.com>
 <YnstyDv0Po5g0W1F@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <YnstyDv0Po5g0W1F@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/11 11:30, Jaegeuk Kim wrote:
> No functional change.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
