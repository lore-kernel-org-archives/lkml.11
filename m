Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FA7C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 31 May 2022 12:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344083AbiEaMDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 May 2022 08:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233781AbiEaMDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 08:03:22 -0400
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752F76D3B5;
        Tue, 31 May 2022 05:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazon201209; t=1653998602; x=1685534602;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Dq4CYzsKphsoAAKN9Kpa4vscL+m6IHrNrwW+RiUQ72E=;
  b=Hai5WvByt8HE9nBaJbJEWQiKqvdg4gWhVMvN8/2m8UkbvR556TGIZpFC
   xVLoqfk1/44xiizvwwriaSuOXz5y+CE7uNcRqta/2nL5Z/bsEZAXVW7Kg
   iKIZsDSQxu8YJNWcmLfp5JR5jb2bdU4khe66lt7nzvYh0erTBEKlXoaO7
   s=;
X-IronPort-AV: E=Sophos;i="5.91,265,1647302400"; 
   d="scan'208";a="223919707"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-6fd66c4a.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP; 31 May 2022 11:43:48 +0000
Received: from EX13D33EUA002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2a-6fd66c4a.us-west-2.amazon.com (Postfix) with ESMTPS id D3FEC815DE;
        Tue, 31 May 2022 11:43:46 +0000 (UTC)
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX13D33EUA002.ant.amazon.com (10.43.165.38) with Microsoft SMTP Server (TLS)
 id 15.0.1497.36; Tue, 31 May 2022 11:43:45 +0000
Received: from dev-dsk-metikaya-1c-d447d167.eu-west-1.amazon.com
 (10.13.250.103) by mail-relay.amazon.com (10.43.60.234) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36 via Frontend Transport; Tue, 31 May 2022
 11:43:42 +0000
From:   Metin Kaya <metikaya@amazon.co.uk>
To:     <jalliste@amazon.com>
CC:     <bp@alien8.de>, <diapop@amazon.co.uk>, <hpa@zytor.com>,
        <jmattson@google.com>, <joro@8bytes.org>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <metikaya@amazon.co.uk>,
        <mingo@redhat.com>, <pbonzini@redhat.com>, <rkrcmar@redhat.com>,
        <sean.j.christopherson@intel.com>, <tglx@linutronix.de>,
        <vkuznets@redhat.com>, <wanpengli@tencent.com>, <x86@kernel.org>
Subject: Re: [PATCH] KVM: VMX: CPU frequency scaling for intel x86_64 KVM guests
Date:   Tue, 31 May 2022 11:43:33 +0000
Message-ID: <20220531114333.29153-1-metikaya@amazon.co.uk>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220531105925.27676-1-jalliste@amazon.com>
References: <20220531105925.27676-1-jalliste@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, Jack.

Reviewed-by: Metin Kaya <metikaya@amazon.co.uk>
