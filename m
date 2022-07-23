Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D31C43334
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jul 2022 03:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236505AbiGWDoe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jul 2022 23:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiGWDo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 23:44:28 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05A2796A8;
        Fri, 22 Jul 2022 20:44:27 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 9CA275C0090;
        Fri, 22 Jul 2022 23:44:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 22 Jul 2022 23:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding:date
        :date:from:from:in-reply-to:message-id:mime-version:reply-to
        :sender:subject:subject:to:to; s=fm3; t=1658547864; x=
        1658634264; bh=Q+2bcuYbqNaeJUyXlpoGM3BHR0EjVdzO4fH/v0jEPL4=; b=7
        t1JRyzTo/cUpqOGjclWdhpSnggdWsoxx/jZXJ8VkWT8hDZgObyUSmHMsJ2rQceMA
        IbsozmiGBQ3OowrBrhrm/UH+cqJQhlYZ5C+FkbxjvZPEf20El5Ez4DkJ7ASqqrdF
        Qm5TWOplLbMpM47m7uuTiQpgMa03O4S1wcjQztwPfT/d8pHPWqb0hXKpMkIa4EHa
        idR00dVzu09I6/vjFlHxpQyCbqbqVSwZn3mmNOZjlYY5MZQHi4wAz11G/2viordE
        Q4PlxgOK8cnhwgLTgp5Uk7V2r7JyRFp8+IbrU8lTHTEBeT8galyYO+n6QgDuAsPv
        7srhaCpCFGUTsg3RwIfFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1658547864; x=1658634264; bh=Q+2bcuYbqNaeJUyXlpoGM3BHR0EjVdzO4fH
        /v0jEPL4=; b=C/uvxx0mgnbPf8amBWXIyKazG/mgZB/TuRDW8v+FCezAN0hkTf8
        iTSiozTjbTDY0H23jRMmUi8ztfOEMhcs4QKabgc67MM4cFFlS9yhJZwxQ7WsWz9W
        XqsrHOSl3eQM0RVG11QRuEKW/XROGXbYbxmm81uJU/R8rPn4MDh2Nj2BBY16sGUz
        DRg3KyI6+HJ4R1EebfS2jPTUJbTEtkqZWoma1I/AHdGEqO2uEQo0aF7rzQJsqPFu
        oCDgsH80JdQ01oipnF80Uqx826dMRaIbuPHMLDIUQt6GU52kycspkpQBMOMWZzEj
        WP/Y4cUcwldoY05nrgdzgiRfikAv3KMGimA==
X-ME-Sender: <xms:mG7bYp0SSDu1O2epo5qXdYmI4DKLiMHovg0lHbC_BxYy7pIzvQqVtw>
    <xme:mG7bYgEXG5VedUng4CiJ81W1FWyvtBJn-CQUsTD7gPT1IqA3KVZVaniEU6Sus0EpP
    -l_3W9c1iRHo5g>
X-ME-Received: <xmr:mG7bYp4JgN3PkCn81nH5t1U0kJ5B19zFe-zfWjqX9tw1o3mkpBTx-hseiFi1tQxpjGlugumJ5If4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddtfedgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepffgvmhhiucfo
    rghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhnghhslh
    grsgdrtghomheqnecuggftrfgrthhtvghrnhepvdefgeekvdekgfffgeekhfeijedtffek
    hefhleehfeejueetgfelgefgtdevieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhslhgr
    sgdrtghomh
X-ME-Proxy: <xmx:mG7bYm14s34XpN5xQtob085psFFMqeXquNUXASotu8SZZtvcQJvN7A>
    <xmx:mG7bYsH4W_eU5AA4Yo361li6oWJgGkvbgIAwhfzwyIKKHc2DXXXGJA>
    <xmx:mG7bYn_seCTnEjhtxtPGahg_cuIIWz2M6LHOoWriiQBfAu3WvFegPg>
    <xmx:mG7bYhMOojthcQuq6c4_QxZxdXgyuzAovJPmAI6Y9AMCf33Pda7JxQ>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Jul 2022 23:44:23 -0400 (EDT)
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Backport of 166d38632316 ("xen/gntdev: Ignore failure to unmap INVALID_GRANT_HANDLE")
Date:   Fri, 22 Jul 2022 23:44:10 -0400
Message-Id: <20220723034415.1560-1-demi@invisiblethingslab.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series backports upstream commit 166d3863231667c4f64dee72b77d1102cdfad11f
to all supported stable kernel trees.
-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab
