Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FB7C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Apr 2022 22:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353128AbiD1XCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Apr 2022 19:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353087AbiD1XCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 19:02:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991BC939FA
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 15:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=b4+AHM7wJy0IuAqNWd732AbrAYFYwHIt1nWPqvpllJA=; b=n2K0M7OQZ4LCAz24evApPafpmc
        u5lkS5owdCeHFbfNk0FvFmzlQRUfbJ3BRHtUVSlveOpaBHkByBfWm83kMgJxp00Y8ZyGm0ADiH78L
        tgDtxLpjtI9BCI7cNlGCqKSQWtraj9RC4eMATVQwrIPAuwbGqET9BVf55Y0Bs65dOJ0QnYp3kiMc8
        53bOJQw0jJKmS31fXj5znSpO66HsX56ms4bwSunMKe7kB7p34UcuuZH29lieSpecb58FxYVZHO1Ls
        bNGdE+fzQwzuRtwa+SkiN+NiB2ZeYvSYJNl0s5alfnfeZilW46tc5LpG01qAsjhwMLWf1dW1Pk4ZB
        0ZE434Pw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkD6g-008uq2-7Y; Thu, 28 Apr 2022 22:59:30 +0000
Date:   Thu, 28 Apr 2022 15:59:30 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Matthias Maennich <maennich@google.com>
Subject: Re: [PATCH] module.h: simplify MODULE_IMPORT_NS
Message-ID: <YmscUrVNYlnNHVbC@bombadil.infradead.org>
References: <20220427090321.2105373-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427090321.2105373-1-gregkh@linuxfoundation.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 11:03:21AM +0200, Greg Kroah-Hartman wrote:
> In commit ca321ec74322 ("module.h: allow #define strings to work with
> MODULE_IMPORT_NS") I fixed up the MODULE_IMPORT_NS() macro to allow
> defined strings to work with it.  Unfortunatly I did it in a two-stage
> process, when it could just be done with the __stringify() macro as
> pointed out by Masahiro Yamada.
> 
> Clean this up to only be one macro instead of two steps to achieve the
> same end result.
> 
> Fixes: ca321ec74322 ("module.h: allow #define strings to work with MODULE_IMPORT_NS")
> Reported-by: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: Matthias Maennich <maennich@google.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks! Queued onto modules-testing. If no complaints come back I'll
move it to modules-next shortly after that.

  Luis
