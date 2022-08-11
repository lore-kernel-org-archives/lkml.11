Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02459C25B0C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Aug 2022 19:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235869AbiHKTlO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Aug 2022 15:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234698AbiHKTlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 15:41:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7577022BEE;
        Thu, 11 Aug 2022 12:41:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27651B82206;
        Thu, 11 Aug 2022 19:41:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67AD8C433D6;
        Thu, 11 Aug 2022 19:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660246867;
        bh=gAAxfoPHl8OGvR/WyakgVLVnHoxFCjBGaBzbS0GzPPQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Pa4ZLUijYuGHlF8LVBOOVXP5HWaVei8WAojWrNOIIhDYGqlNr2bolJ3JINqRgRCjQ
         kWGcwnCQEiKFRQaKosgDUZ1r+yHVQXarC45LmwVxVe4Lx67yFPOfp7voQYLfNo93nq
         LM+qQsipnVb+UPwpLyzCjT6beAvmkfZi06LSgTClOgooWBefaxqlWimnzlLaTzZqJV
         y+ifV+H2roPEkQMK8ded8e62t3Tmvu8USq1S2OdPy3kYqIZLVyZvd4zvybOaz/V8xE
         oL9p4nLQYprXoRgnTMANcqIrQw0qAlWDCrOxvkMj16OTodvKyi38/iIniEU+Ocgo8H
         jb1nKNF7KpBdA==
Date:   Thu, 11 Aug 2022 12:41:06 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PULL] Networking for 6.0-rc1
Message-ID: <20220811124106.703917f8@kernel.org>
In-Reply-To: <20220811120902.7e82826a@kernel.org>
References: <20220811185102.3253045-1-kuba@kernel.org>
        <20220811120902.7e82826a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Aug 2022 12:09:02 -0700 Jakub Kicinski wrote:
> Let's put this one on hold, sorry. We got a report 2 minutes after
> sending that one of the BT patches broke mips and csky builds :S
> I'll try to get hold of Luiz and fix that up quickly.

Can I take that back? I can't repro with the cross compiler 
from kernel.org. I'll follow up with the reported separately.
